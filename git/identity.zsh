
#!/usr/bin/env zsh

git-identities() {
  git config --get-regexp '^identity\.' | cut -d"." -f2 | sort -u
}

git-assume() {
  command git-assume "$@"
}
