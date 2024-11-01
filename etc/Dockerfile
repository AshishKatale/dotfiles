# docker build --build-arg NODE_VERSION="20.11.0" --build-arg NVM_VERSION="0.39.7" --build-arg VAULT_PASS="pw" -t archlinux:config .
FROM archlinux:latest
ARG NODE_VERSION
ARG NVM_VERSION
ARG VAULT_PASS

RUN pacman -Syy
RUN yes | pacman -S openssh git stow vim zsh which
RUN yes | pacman -S neovim lazygit vifm bat ripgrep fd fzf tmux jq htmlq zip unzip wget curl
RUN yes | pacman -S gcc go diffutils

WORKDIR /root
RUN git config --global user.name "Ashish Katale"
RUN git config --global user.email "61214878+AshishKatale@users.noreply.github.com"
RUN git clone https://github.com/AshishKatale/dotfiles.git

WORKDIR /root/dotfiles
RUN stow lazygit nvim scripts tmux vifm
RUN git remote set-url origin git@github.com:AshishKatale/dotfiles.git
RUN openssl enc -aes256 -d -md sha1 -iter 1000000 -a -pass "pass:$VAULT_PASS" -in /root/dotfiles/etc/ssh/id_ed25519 -out /root/.ssh/id_ed25519
RUN openssl -f /root/.ssh/id_ed25519 -y > /root/.ssh/id_ed25519.pub
RUN chmod 600 /root/.ssh/id_rsa

WORKDIR /root/dotfiles/scripts/bin
RUN yes | ./setupzsh
WORKDIR /root
RUN mkdir workspace
RUN curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | bash -s -- -y
RUN source /root/.cargo/env && rustup component add rust-analyzer
RUN mkdir /root/.nvm
ENV NVM_DIR /root/.nvm
RUN curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh" | bash \
  && . /root/.nvm/nvm.sh \
  && nvm install "v$NODE_VERSION" \
  && npm i -g npm \
  && echo ". /root/.nvm/nvm.sh" >> .zshenv
RUN chsh -s /bin/zsh
CMD ["zsh"]

