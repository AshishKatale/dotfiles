lazynvm() {
  unset -f nvm node npm npx nvim pnpm
  export NVM_DIR=$HOME/.local/nvm
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

pnpm() {
  lazynvm
  pnpm $@
}

nvim() {
  lazynvm
  nvim $@
}

