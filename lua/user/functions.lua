-- lua/user/functions.lua
local M = {}

M.smart_quit = function()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local actions = require("telescope.actions")
  local previewers = require("telescope.previewers")

  local modified_bufs = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_get_option_value("modified", { buf = buf }) then
      table.insert(modified_bufs, {
        bufnr = buf,
        name = vim.api.nvim_buf_get_name(buf),
      })
    end
  end

  if #modified_bufs == 0 then
    vim.cmd("qa")
    return
  end

  pickers
      .new({}, {
        initial_mode = "normal",
        prompt_title = "Unsaved: <C-s> Save/Quit | <C-q> Discard/Quit",
        finder = finders.new_table({
          results = modified_bufs,
          entry_maker = function(entry)
            local display_name = (entry.name == "") and "[No Name]" or vim.fn.fnamemodify(entry.name, ":.")
            return {
              value = entry,
              display = display_name,
              ordinal = display_name,
            }
          end,
        }),
        previewer = previewers.new_buffer_previewer({
          title = "Unified Diff (Buffer vs Disk)",
          define_preview = function(self, entry)
            local bufnr = entry.value.bufnr
            local original_file = entry.value.name

            -- Handle new files that don't exist on disk yet
            if original_file == "" or vim.fn.filereadable(original_file) == 0 then
              local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
              vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
              return
            end

            local content = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            local tmp_file = os.tmpname()
            local f = io.open(tmp_file, "w")
            if f then
              f:write(table.concat(content, "\n"))
              f:close()
            end

            local diff_cmd = string.format(
              "diff -u --label 'Original' --label 'Unsaved' %s %s",
              vim.fn.shellescape(original_file),
              vim.fn.shellescape(tmp_file)
            )

            local handle = io.popen(diff_cmd)

            if not handle then
              vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, { "Error generating diff." })
              return
            end

            local diff_result = handle:read("*a")
            handle:close()
            os.remove(tmp_file)

            vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.split(diff_result, "\n"))
            vim.api.nvim_set_option_value("filetype", "diff", { buf = self.state.bufnr })
          end,
        }),
        attach_mappings = function(prompt_bufnr, map)
          -- Shortcut: Save All and Quit
          local save_all_and_quit = function()
            actions.close(prompt_bufnr)
            vim.cmd("wa")
            vim.cmd("qa")
          end

          local close_picker = function()
            actions.close(prompt_bufnr)
          end

          -- Shortcut: Force Quit without Saving
          local force_quit = function()
            actions.close(prompt_bufnr)
            vim.cmd("qa!")
          end
          map("n", "q", close_picker)
          map("i", "<C-s>", save_all_and_quit)
          map("n", "<C-s>", save_all_and_quit)
          map("i", "<C-q>", force_quit)
          map("n", "<C-q>", force_quit)

          return true
        end,
      })
      :find()
end

M.pull_workspace_diagnostics = function()
  local clients = vim.lsp.get_clients({ name = "csharp_ls" })

  for _, client in ipairs(clients) do
    if client:supports_method("workspace/diagnostic") then
      client:request("workspace/diagnostic", { previousResultIds = {} }, function(err, result)
        if err then
          vim.notify("LSP Error: " .. err.message, vim.log.levels.ERROR)
          return
        end
        if not result or not result.items then return end

        -- Manually process each item in the workspace report
        for _, report in ipairs(result.items) do
          if report.items then -- This is the list of actual diagnostics
            local uri = report.uri
            local bufnr = vim.uri_to_bufnr(uri)

            -- Push the diagnostics into Neovim's engine for this specific file
            vim.lsp.diagnostic.on_publish_diagnostics(nil, {
              uri = uri,
              diagnostics = report.items
            }, { client_id = client.id, bufnr = bufnr })
          end
        end
      end)
    end
  end
end

return M
