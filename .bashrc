
alias ls='ls -laG'
alias lst='ls -latG'
alias ..="cd .."
alias up="cd ..; ls"

alias ssh_ec2ytakahashi='ssh -l ytakahashi -i "/Users/ytakahashi/.ssh/id_rsa" ec2-54-178-82-69.ap-northeast-1.compute.amazonaws.com'


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

