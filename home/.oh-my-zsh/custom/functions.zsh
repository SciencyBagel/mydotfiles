rgf ()
{
  local RELOAD='rg --column --line-number --no-heading --smart-case --color=always -- {q} || true'

  fzf --disabled --ansi --query "" \
  --bind "change:reload:$RELOAD" \
  --preview 'bat --color=always {1} --highlight-line {2}' \
  --preview-window 'right:50%:+{2}+3/3' \
  --bind 'enter:become(nvim {1} +{2})'
}
