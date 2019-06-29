FROM alpine

RUN apk add --no-cache g++ openssl-dev git make
RUN apk add --no-cache python2 python3 py2-pip python2-dev python3-dev
RUN pip2 install neovim
RUN pip3 install neovim
RUN pip3 install six git+git://github.com/robgolding63/tasklib@develop
RUN pip2 install --upgrade pip
RUN pip3 install --upgrade pip

RUN apk add --no-cache ruby ruby-dev
RUN gem install neovim --no-ri --no-rdoc

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

RUN apk add --no-cache \
      make ctags \
      wget curl \
      git \
      less file \
      ca-certificates \
      sudo \
      gnupg \
      npm yarn \
      fzf \
      bash \
      ruby \
      python2 python3 py2-pip \
      coreutils grep \
      neovim

RUN apk add --no-cache tmux

RUN ln -sfn nvim /usr/bin/vim
RUN yarn global add neovim

RUN apk add --no-cache task

WORKDIR /root/.vim

RUN mkdir /root/.config
RUN ln -sfn /root/.vim /root/.config/nvim


COPY . .

RUN echo ruby_solargraph=n >> .config
RUN echo clipboard_shared=n >> .config

RUN make configure
RUN make deps
RUN make install
