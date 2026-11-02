-- Función auxiliar local para extraer la selección visual
local function get_visual_selection()
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "\22" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "x", false)
  end

  local start_pos = vim.api.nvim_buf_get_mark(0, "<")
  local end_pos = vim.api.nvim_buf_get_mark(0, ">")
  local lines = vim.api.nvim_buf_get_lines(0, start_pos[1] - 1, end_pos[1], false)

  if #lines == 0 then return "" end

  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_pos[2] + 1, end_pos[2] + 1)
  else
    lines[1] = string.sub(lines[1], start_pos[2] + 1)
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[2] + 1)
  end

  return table.concat(lines, " ")
end

return {
  "lalitmee/browse.nvim",
  event = "VeryLazy",
  keys = {
    -- 1. Búsqueda libre con texto seleccionado (modo visual 'x')
    {
      "<leader>ff",
      function()
        local query = get_visual_selection()
        require("browse").input_search(query ~= "" and query or nil)
      end,
      mode = "x",
      desc = "Search on web (visual selection)",
    },
    -- 2. Búsqueda en bookmarks manuales con texto seleccionado (modo visual 'x')
    {
      "<leader>fb",
      function()
        local query = get_visual_selection()
        -- Función oficial documentada en browse.nvim para abrir marcadores manuales
        require("browse").open_manual_bookmarks(query ~= "" and { visual_text = query } or nil)
      end,
      mode = "x",
      desc = "Search on web bookmarks (visual selection)",
    },
    -- 3. Búsqueda usando la palabra bajo el cursor (modo normal 'n')
    {
      "<leader>fw",
      function()
        local word = vim.fn.expand "<cword>"
        if word ~= "" then
          require("browse").input_search(word)
        else
          require("browse").input_search()
        end
      end,
      mode = "n",
      desc = "Search web for word under cursor",
    },
    -- 4. Comandos por defecto sin selección
    { "<leader>fi", "<cmd>Browse input<cr>", desc = "Search on web input" },
    { "<leader>fs", "<cmd>Browse bookmarks<cr>", desc = "Search on web bookmarks" },
  },
  opts = {
    picker = "snacks",
    bookmarks = {
      github = {
        name = "search github from neovim",
        code_search = "https://github.com/search?q=%s&type=code",
        repo_search = "https://github.com/search?q=%s&type=repositories",
        issues_search = "https://github.com/search?q=%s&type=issues",
        pulls_search = "https://github.com/search?q=%s&type=pullrequests",
      },
      searchix = "https://searchix.ovh/?query=%s",
      astrocommunity = "https://astronvim.github.io/astrocommunity/",
      npm = "https://www.npmjs.com/search?q=%s",
      pipy = "https://pypi.org/search/?q=%s",
      stackoverflow = "https://stackoverflow.com/search?q=%s",
      youtube = "https://www.youtube.com/results?search_query=%s&page=&utm_source=opensearch",
    },
  },
}
