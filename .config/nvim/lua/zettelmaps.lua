vim.keymap.set("n", "<leader>zn", function()
  local notes_dir = vim.fn.expand("~/orgfiles/notes/")

  -- Ensure directory exists
  vim.fn.mkdir(notes_dir, "p")

  -- Get title
  local title = vim.fn.input("Permanent Note Title: ")
  if title == "" then return end

  -- Generate ID + slug
  local id = os.date("%Y%m%d%H%M%S")
  local slug = title
    :lower()
    :gsub("[^a-z0-9 ]", "")
    :gsub("%s+", "-")

  local filename = notes_dir .. id .. "-" .. slug .. ".org"

  -- Open/create file
  vim.cmd("edit " .. filename)

  -- Only insert template if file is new
  if vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
    vim.api.nvim_buf_set_lines(0, 0, -1, false, {
      ":PROPERTIES:",
      ":ID: " .. id,
      ":END:",
      "",
      "#+title: " .. title,
      "#+date: " .. os.date("%Y-%m-%d"),
      "#+filetags: ",
      "",
      "* Idea",
      "",
      "* Connections",
      "",
      "* References",
      "",
    })
  end

  -- Move cursor to "Idea" section
  vim.api.nvim_win_set_cursor(0, {8, 0})

  -- Enter insert mode
  vim.cmd("startinsert")
end)
