FROM archlinux:latest
RUN pacman -Syy

RUN yes | pacman -S git stow vim vifm zsh which
RUN yes | pacman -S neovim lazygit bat ripgrep fd fzf tmux jq htmlq zip unzip wget curl
RUN yes | pacman -S gcc diffutils

WORKDIR /root
RUN git config --global user.name "Ashish Katale"
RUN git config --global user.email "61214878+AshishKatale@users.noreply.github.com"

RUN git clone https://github.com/AshishKatale/dotfiles.git
WORKDIR /root/dotfiles
RUN stow */
WORKDIR /root/dotfiles/scripts/bin
RUN yes | ./setupzsh
WORKDIR /root
RUN echo "DOTFILES=/root/dotfiles" >> .zshenv
RUN mkdir -p Workspace/Go/learn Workspace/Rust/learn Workspace/Web/learn
RUN curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | bash -s -- -y
RUN source /root/.cargo/env && rustup component add rust-analyzer
RUN mkdir /root/.nvm
ENV NVM_DIR /root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash \
  && . /root/.nvm/nvm.sh \
  && nvm install "v{VERSION}"
  && npm i -g npm
  && echo ". /root/.nvm/nvm.sh" >> .zshenv
RUN chsh -s /bin/zsh
CMD ["zsh"]

