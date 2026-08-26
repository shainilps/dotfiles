-- A mini.diff source backed by jujutsu.
--
-- mini.diff only ships a git source, and that one diffs against the git index.
-- jj has no index, so in a jj repo the sign column just goes blank. This gets
-- the same reference text out of jj instead: the file as of `@-`.
--
-- View only. It sets reference text and nothing else, so signs, `]h` / `[h` and
-- `gH` reset behave exactly as they do on git. Nothing is ever written back to
-- jj -- `gH` restores buffer lines from the reference text and runs no VCS
-- command at all.
--
-- Meant to be the first entry of mini.diff's `source` array. Outside a jj repo
-- `attach` returns false, which is how mini.diff falls through to the git
-- source.

local M = {}

-- Revision each buffer is compared against. `@-`, the parent of the working
-- copy, is the jj analogue of git's index: the diff is everything you have
-- changed in the current change, and it clears on `jj new`.
local REV = "@-"

-- Coalescing window for refreshes, in ms. One jj operation rewrites the op head
-- several times, so without this a single `jj squash` would spawn a handful of
-- `jj file show` processes per buffer.
local DEBOUNCE = 50

-- Buffers this source is currently attached to. Also the guard that keeps an
-- in-flight jj call from acting on a buffer that has since detached:
-- MiniDiff.set_ref_text re-enables a disabled buffer, so a late callback could
-- otherwise resurrect one.
local attached = {}

-- Attached buffer -> the repo directory whose watcher it is registered with.
local buf_repos = {}

-- One filesystem watcher per repo directory, tracking the buffers attached to
-- it. jj rewrites `<repo>/op_heads/heads` on every operation (new, squash,
-- edit, ...), so watching it refreshes signs when jj state changes in another
-- terminal.
local watchers = {}

-- Pending refresh timers, keyed by buffer.
local timers = {}

--- Repo root and repo-relative path for a buffer, or nil if it is not a real
--- file inside a jj repo.
local function resolve(buf_id)
	local name = vim.api.nvim_buf_get_name(buf_id)
	if name == "" then
		return nil
	end

	-- Resolving symlinks matters for a stow-style dotfiles setup: the repo
	-- marker sits next to the real file, not next to the link.
	local path = vim.uv.fs_realpath(name)
	if path == nil then
		return nil
	end

	local dir = vim.fs.dirname(path)
	local root = nil
	while dir do
		if vim.uv.fs_stat(dir .. "/.jj") ~= nil then
			root = dir
			break
		end
		if vim.uv.fs_stat(dir .. "/.git") ~= nil then
			return nil -- nearest marker is git, not jj
		end
		local parent = vim.fs.dirname(dir)
		if parent == dir then
			break -- hit filesystem root
		end
		dir = parent
	end
	if root == nil then
		return nil
	end
	local rel = vim.fs.relpath(root, path)
	if rel == nil then
		return nil
	end

	return { root = root, rel = rel }
end

--- jj parses a bare path argument as a fileset expression, where `~`, `&` and
--- `:` are operators -- `a~b.txt` quietly matches nothing rather than erroring.
--- The quoted form is literal, and `root-file:` is anchored at the repo root so
--- it resolves the same from any working directory.
local function fileset(rel)
	local escaped = rel:gsub("\\", "\\\\")
	escaped = escaped:gsub('"', '\\"')
	return 'root-file:"' .. escaped .. '"'
end

local function set_ref_text(buf_id)
	if attached[buf_id] == nil or not vim.api.nvim_buf_is_valid(buf_id) then
		return
	end
	local target = resolve(buf_id)
	if target == nil then
		return
	end

	-- `--ignore-working-copy` keeps a sign refresh from snapshotting the working
	-- copy; without it, merely browsing files would pile up jj operations.
	-- `--color=never` keeps ANSI escapes out of stderr, which is inspected below.
	local cmd = {
		"jj",
		"file",
		"show",
		"--ignore-working-copy",
		"--color=never",
		"-r",
		REV,
		fileset(target.rel),
	}

	-- vim.system raises rather than returning an error, e.g. if `jj` left $PATH
	-- mid-session. Hand the buffer to the next source instead of throwing out of
	-- an autocmd on every refresh.
	local ok = pcall(
		vim.system,
		cmd,
		{ cwd = target.root, text = true },
		vim.schedule_wrap(function(obj)
			if attached[buf_id] == nil or not vim.api.nvim_buf_is_valid(buf_id) then
				return
			end

			local text
			if obj.code == 0 then
				text = obj.stdout
			elseif (obj.stderr or ""):find("No such path", 1, true) then
				-- Absent from REV, i.e. the file is new. Empty reference text
				-- renders that as an all-added buffer.
				text = ""
			else
				-- Any other failure is real -- `@` being a merge makes `@-`
				-- ambiguous, for one. Unset the reference so no hunks are shown,
				-- rather than claiming the whole file is new. This is what
				-- mini.diff's own git source does on error.
				text = nil
			end
			pcall(require("mini.diff").set_ref_text, buf_id, text)
		end)
	)
	if not ok then
		pcall(require("mini.diff").fail_attach, buf_id)
	end
end

local function stop_timer(buf_id)
	local timer = timers[buf_id]
	if timer ~= nil then
		timers[buf_id] = nil
		timer:stop()
		timer:close()
	end
end

local function schedule_ref_text(buf_id)
	if timers[buf_id] ~= nil then
		return
	end
	local timer = vim.uv.new_timer()
	if timer == nil then
		return set_ref_text(buf_id)
	end
	timers[buf_id] = timer
	timer:start(
		DEBOUNCE,
		0,
		vim.schedule_wrap(function()
			stop_timer(buf_id)
			set_ref_text(buf_id)
		end)
	)
end

local function group_name(buf_id)
	return "MiniDiffSourceJj" .. buf_id
end

--- The directory holding shared repo state, given a workspace root. Usually
--- `<root>/.jj/repo`, but in a secondary workspace made by `jj workspace add`
--- that is a regular file naming the main repo's directory instead. Keying
--- watchers off the result means sibling workspaces share a single watcher.
local function repo_dir(root)
	local jj_dir = root .. "/.jj"
	local repo = jj_dir .. "/repo"
	local stat = vim.uv.fs_stat(repo)
	if stat == nil then
		return nil
	end
	if stat.type == "directory" then
		return repo
	end

	local fd = io.open(repo, "r")
	if fd == nil then
		return nil
	end
	local target = vim.trim(fd:read("*a") or "")
	fd:close()
	if target == "" then
		return nil
	end
	-- The recorded path may be relative to `.jj/`.
	if not vim.startswith(target, "/") then
		target = jj_dir .. "/" .. target
	end
	return vim.uv.fs_realpath(target)
end

local function refresh_watcher(repo)
	local watcher = watchers[repo]
	if watcher == nil then
		return
	end
	for buf_id in pairs(watcher.buffers) do
		if vim.api.nvim_buf_is_valid(buf_id) then
			schedule_ref_text(buf_id)
		else
			watcher.buffers[buf_id] = nil
		end
	end
end

local function start_watcher(repo)
	local watcher = { buffers = {} }
	local heads = repo .. "/op_heads/heads"
	local handle = vim.uv.fs_stat(heads) ~= nil and vim.uv.new_fs_event() or nil
	if handle ~= nil then
		-- An operation removes the old head and adds the new one, firing several
		-- events; the per-buffer debounce collapses them into one refresh.
		local ok = handle:start(heads, {}, function(err)
			if err then
				return
			end
			vim.schedule(function()
				refresh_watcher(repo)
			end)
		end)
		if ok then
			watcher.handle = handle
		else
			handle:close()
		end
	end
	watchers[repo] = watcher
	return watcher
end

local function stop_watcher(repo)
	local watcher = watchers[repo]
	if watcher == nil then
		return
	end
	watchers[repo] = nil
	if watcher.handle ~= nil then
		watcher.handle:stop()
		watcher.handle:close()
	end
end

local function attach(buf_id)
	-- Returning false is what hands the buffer to the next source, i.e. git.
	if vim.fn.executable("jj") ~= 1 then
		return false
	end
	local target = resolve(buf_id)
	if target == nil then
		return false
	end

	local group = vim.api.nvim_create_augroup(group_name(buf_id), { clear = true })
	-- `@-` only moves when a jj operation runs, which the op-heads watcher
	-- already catches, and mini.diff recomputes hunks itself as the buffer
	-- changes. Writing or entering a buffer cannot change `@-`, so these are
	-- only cheap safety nets for when the watcher could not be established.
	vim.api.nvim_create_autocmd({ "BufReadPost", "FocusGained", "FileChangedShellPost" }, {
		group = group,
		buffer = buf_id,
		desc = "Refresh jj diff reference",
		callback = function()
			schedule_ref_text(buf_id)
		end,
	})

	attached[buf_id] = true

	local repo = repo_dir(target.root)
	if repo ~= nil then
		local watcher = watchers[repo] or start_watcher(repo)
		watcher.buffers[buf_id] = true
		buf_repos[buf_id] = repo
	end

	set_ref_text(buf_id)
end

--- Safe to call even if `attach` bailed out early.
local function detach(buf_id)
	pcall(vim.api.nvim_del_augroup_by_name, group_name(buf_id))
	attached[buf_id] = nil
	stop_timer(buf_id)

	local repo = buf_repos[buf_id]
	buf_repos[buf_id] = nil
	local watcher = repo ~= nil and watchers[repo] or nil
	if watcher ~= nil then
		watcher.buffers[buf_id] = nil
		if next(watcher.buffers) == nil then
			stop_watcher(repo)
		end
	end
end

M.source = { name = "jj", attach = attach, detach = detach }

return M
