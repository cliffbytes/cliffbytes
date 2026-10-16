alias ..="cd .."

alias lock="dm-tool lock"

mkcd() {
  mkdir -p "$1" && cd "$1"
}
