# Fuzzy grep with ripgrep + fzf, opens result in $EDITOR
function frg {

  local result

  # Run rg, pipe into fzf with a bat preview
  result=$(
    rg --line-number --color=always "${1:-}" \
      | fzf \
          --ansi \
          --delimiter=: \
          --preview 'bat --color=always {1} --highlight-line {2}' \
          --preview-window 'right:60%:+{2}-5' \
          --query "${1:-}"   # pre-fill fzf query with your arg if given
  )

  # If user selected something, open it in your editor at the right line
  [[ -n "$result" ]] || return

  local file line
  file=$(echo "$result" | cut -d: -f1)   # field 1 = filename
  line=$(echo "$result" | cut -d: -f2)   # field 2 = line number

  "${EDITOR:-vim}" +"$line" "$file"       # +N tells vim/nvim to jump to line N
}
