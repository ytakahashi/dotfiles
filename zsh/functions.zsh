# shell functions

cdf () {
  local target
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]
  then
    cd "$target"
    pwd
  else
    echo 'No Finder window found' >&2
  fi
}

mkcd() {
  mkdir $1;
  cd $1;
}

pwd-clip() {
    local copyToClipboard

    if which pbcopy >/dev/null 2>&1 ; then
        # Mac
        copyToClipboard='pbcopy'
    elif which xsel >/dev/null 2>&1 ; then
        # Linux
        copyToClipboard='xsel --input --clipboard'
    elif which putclip >/dev/null 2>&1 ; then
        # Cygwin
        copyToClipboard='putclip'
    else
        copyToClipboard='cat'
    fi

    # ${=VAR} enables SH_WORD_SPLIT option
    # so ${=VAR] is splited in words, for example "a" "b" "c"
    echo -n $PWD | ${=copyToClipboard}
}

h() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

lsa() {
  local res=$(find . -maxdepth 1 -mindepth 1 -type d | awk -F'[/]' '{print $2}')
  local ary=(`echo $res`)
  for i in ${ary[@]}; do
    echo $PWD/$i
    ls -la $i
    echo "\n"
  done
}

##
# vim
##
fv() {
  local file depth
  depth=${1:-2}

  file=$(
    find . -type d -name .git -prune -o -type f -maxdepth ${depth} |
    fzf +m
  )

  if [[ -z "$file" ]]; then
      return 0
  fi

  print -z "vim $file"
}

##
# Open browser of ghq-managed git remote repositories.
##
browse() {
  local host protocol browser

  protocol="https://"

  if [ -n "$1" -a "$1" = "." ]; then
    browser=${2:-"Safari"}
    host=$(echo $(git rev-parse --show-toplevel) | sed -e "s:$(ghq root)/::")
  else
    browser=${1:-"Safari"}
    host=$(ghq list | fzf +m)
  fi

  if [[ -z "$host" ]]; then
      return 0
  fi

  open -a $browser $protocol$host

}

##
# interactive cd to ghq-managed git local repositories.
##
gd() {
  local dir
  dir=$(ghq list -p | fzf +m)

  if [[ -z "$dir" ]]; then
      return 0
  fi

  cd $dir
  pwd
}

##
# interactive cd to go src repositories.
##
gdgo() {
  local dir
  dir=$(find $GOPATH/src -maxdepth 3 -mindepth 3  -type d | fzf +m)

  if [[ -z "$dir" ]]; then
      return 0
  fi

  cd $dir
  pwd
}

##
# interactive cd to recorded directory.
##
pd() {
  local dir
  dir=$(dirs -lp | fzf +m)

  if [[ -z "$dir" ]]; then
      return 0
  fi

  cd "$dir"
  pwd
}

##
# interactive cd to selected directory under current directory
##
fd() {
  local dir depth
  depth=${1:-1}

  dir=$(
    find . -path '*/\.*' -prune -o -type d -print -maxdepth ${depth} |
    fzf +m
  )

  if [[ -z "$dir" ]]; then
    return 0
  fi

  cd $dir
  pwd
}

##
# interactive ssh to a host listed in ~/.ssh/config
##
fssh () {
  local host
  host=$(
    grep "Host " ~/.ssh/config |
    grep -v '*' |
    awk {'print $2'} |
    fzf +m
  )

  if [[ -z "$host" ]]; then
    return 0
  fi

  print -z "ssh $host"
}

get_session_token () {
  local result
  result=$(aws sts get-session-token --serial-number $1 --token-code $2)
  if [ $? -gt 0 ]; then
    return 1
  fi

  local key=$(echo $result | jq '.Credentials' | jq -r '.AccessKeyId')
  local secret=$(echo $result | jq '.Credentials' | jq -r '.SecretAccessKey')
  local token=$(echo $result | jq '.Credentials' | jq -r '.SessionToken')
  local expiration=$(echo $result | jq '.Credentials' | jq -r '.Expiration')

  printf 'expiration = %s\n' $=expiration
  printf 'aws_access_key_id = %s\n' $=key
  printf 'aws_secret_access_key = %s\n' $=secret
  printf 'aws_session_token = %s\n' $=token
}

get-private-ip () {
  aws ec2 describe-instances --profile $3 --region $4 --instance-ids $(aws ecs describe-container-instances --profile $3 --region $4 --cluster $1 --container-instances $(aws ecs describe-tasks --profile $3 --region $4 --cluster $1 --tasks $(aws ecs --profile $3 --region $4 list-tasks --cluster $1 --service-name $2 | jq -r '.taskArns[]') | jq -r '.tasks[].containerInstanceArn') | jq -r '.containerInstances[].ec2InstanceId') | jq -r '.Reservations[].Instances[].PrivateIpAddress'
}

get-service-name () {
  aws ecs list-services --profile $2 --region $3 --cluster $1 | jq -r '.serviceArns[]' | awk -F "/" '{print $NF}' | fzf
}

get-cluster-name () {
  aws ecs list-clusters --profile $1 --region $2 | jq -r '.clusterArns[]' | awk -F "/" '{print $NF}' | fzf
}

get-container-instance-private-ip () {
  local profile=$1
  local region=$2
  local cluster=$(get-cluster-name ${profile} ${region})
  local service=$(get-service-name ${cluster} ${profile} ${region})
  get-private-ip ${cluster} ${service} ${profile} ${region}
}
