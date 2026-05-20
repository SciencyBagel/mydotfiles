return {
  "windwp/nvim-autopairs",

  -- stop auto-parens on completion
  config = function(_, opts)
    local autopairs = require("nvim-autopairs")
    autopairs.setup(opts)
  end
}
