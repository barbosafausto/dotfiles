# no final do user.zsh
_fix_vi_mode() {
  bindkey -v
  bindkey '^?' backward-delete-char
  bindkey '^H' backward-delete-char
  bindkey '^W' backward-kill-word
  add-zsh-hook -d precmd _fix_vi_mode
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _fix_vi_mode

