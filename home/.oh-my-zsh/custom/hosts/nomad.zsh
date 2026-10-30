# uv autocompletion
if command -v uv &> /dev/null; then
  source <(uv generate-shell-completion zsh)
fi
