FROM alpine:latest

LABEL description="Dockerfile for dofiles"
LABEL maintainer="ytakahashi"

RUN apk update && \
  apk upgrade && \
  apk add --no-cache \
  git \
  bash \
  zsh \
  zsh-vcs \
  make \
  ncurses

WORKDIR /root/dotfiles

COPY . .

ENV TERM=xterm-256color

RUN make dotfiles

CMD zsh
