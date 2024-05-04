-----------------------------------------------------------
-- Auto-Paris
-----------------------------------------------------------
return {
  "windwp/nvim-autopairs",
  opts = {
    check_ts = true,
    map_cr = true, --  map <CR> on insert mode
    map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
    auto_select = true, -- auto select first item
    map_char = {
      -- modifies the function or method delimiter by filetypes
      all = "(",
      tex = "{",
    },
  },
}