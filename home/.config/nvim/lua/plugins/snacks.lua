-- lua/plugins/snacks.lua
-- Override the snacks.nvim dashboard header.
-- Using opts as a function ensures we're patching LazyVim's existing
-- snacks config rather than replacing it wholesale.

return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    -- opts here is LazyVim's already-built snacks config.
    -- We drill into dashboard.preset and set only the header.
    opts.dashboard = opts.dashboard or {}
    opts.dashboard.preset = opts.dashboard.preset or {}
    opts.dashboard.preset.header = [[
 ██████   █████                                        █████
░░██████ ░░███                                        ░░███
 ░███░███ ░███   ██████  █████████████    ██████    ███████
 ░███░░███░███  ███░░███░░███░░███░░███  ░░░░░███  ███░░███
 ░███ ░░██████ ░███ ░███ ░███ ░███ ░███   ███████ ░███ ░███
 ░███  ░░█████ ░███ ░███ ░███ ░███ ░███  ███░░███ ░███ ░███
 █████  ░░█████░░██████  █████░███ █████░░████████░░████████
░░░░░    ░░░░░  ░░░░░░  ░░░░░ ░░░ ░░░░░  ░░░░░░░░  ░░░░░░░░
    ]]

    opts.picker.sources = opts.picker.sources or {}
    opts.picker.sources.explorer = opts.picker.sources.explorer or {}
    opts.picker.sources.explorer.hidden = true
  end,
}
