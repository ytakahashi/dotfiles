
alias ls='ls -laG'
alias lst='ls -latG'
alias lsd='ls -lad $PWD/*'
alias ..="cd .."
alias up="cd ..; ls"

alias prox='export ALL_PROXY=proxy.sonycity.sony.co.jp:10080'

alias ssh_ec2ytakahashi='ssh -l ytakahashi -i "/Users/ytakahashi/.ssh/id_rsa" ec2-54-178-82-69.ap-northeast-1.compute.amazonaws.com'
alias ssh_ytakahashi_linux='ssh -l ytakahashi 43.22.66.62'
alias ssh_dns01='ssh 43.22.66.201'
alias ssh_hornet='ssh hornet.rd.scei.sony.co.jp'
alias ssh_raptor='ssh raptor.rd.scei.sony.co.jp'
alias ssh_opengrok='ssh 43.22.66.207'


alias git_a='git add .'
alias git_c_m='git commit -m'
alias git_p='git push'
alias git_f='git fetch'
alias git_m='git merge'


to_trash() {
  for file in $@
  do
    mv $file ~/.Trash
  done
}

cdf () {
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]
  then
    cd "$target"
    pwd
  else
    echo 'No Finder window found' >&2
  fi
}

alias rm='to_trash'

alias f="open ."

alias vbp='vim ~/.bash_profile'
alias vbr='vim ~/.bashrc'
alias vvr='vim ~/.vimrc'
alias sbp='source ~/.bash_profile'

