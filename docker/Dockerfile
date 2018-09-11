FROM centos:7

RUN localedef -f UTF-8 -i en_US en_US.UTF-8
ENV \
  LANG="en_US.UTF-8" \
  LANGUAGE="en_US:en" \
  LC_ALL="en_US.UTF-8"

RUN \
  yum -y update && \
  yum clean all

RUN yum -y install git zsh vim make

RUN curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

RUN \
  git clone https://github.com/ytakahashi/dotfiles.git ~/dotfiles && \
  cd ~/dotfiles && \
  make clean && \
  make dotfiles

CMD zsh
