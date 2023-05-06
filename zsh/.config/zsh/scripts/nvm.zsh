lazynvm() {
  unset -f nvm node npm npx nvim
  export NVM_DIR=~/.local/nvm
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
}

nvm() {
  lazynvm
  nvm $@
}

node() {
  lazynvm
  node $@
}

npm() {
  lazynvm
  npm $@
}

npx() {
  lazynvm
  npx $@
}

nvim() {
  lazynvm
  nvim $@
}

