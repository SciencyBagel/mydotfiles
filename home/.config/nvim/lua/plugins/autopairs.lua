-- lua/plugins/autopairs.lua

return {
  "windwp/nvim-autopairs",
  -- Override the config function so we can skip the cmp integration
  config = function(_, opts)
    local autopairs = require("nvim-autopairs")
    autopairs.setup(opts)

    -- LazyVim's default wires this up, which causes the auto-parens on completion:
    -- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    -- require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    --
    -- By not calling the above, we keep autopairs for brackets/quotes
    -- but stop it from appending () after function completions.
  end,
}
