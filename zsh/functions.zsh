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
  browser=${1:-"Google Chrome"}
  host=$(ghq list | fzf +m)

  if [[ -z "$host" ]]; then
      return 0
  fi

  open -a $browser $protocol$host
}

##
# Open remote repository of ghq-managed or go src git repositories.
##
open_remote() {
  local host protocol browser ghq_root go_src
  protocol="https://"
  browser=${1:-"Google Chrome"}

  ghq_root=$(ghq root)
  go_src=$(echo $GOPATH/src)

  if [[ $PWD == *$ghq_root* ]]; then
    host=$(echo $(git rev-parse --show-toplevel) | sed -e "s:$ghq_root/::")
  elif [[ $PWD == *$go_src* ]]; then
    host=$(echo $(git rev-parse --show-toplevel) | sed -e "s:$go_src/::")
  else
    echo "Cannot open."
    return 0
  fi

  open -a $browser $protocol$host
}

##
# Open tag diff page with browser.
##
git_open_tag_diff() {
  local diff=$(git tag | fzf -m 2 --print0 | tr '\000' ' ' | sed -e 's/ $//' -e 's/ /.../g')
  echo "$(remote_repository_url)/compare/$diff"
  open -a ${1:-"Google Chrome"} "$(remote_repository_url)/compare/$diff"
}

##
# Shows url of remote repository of ghq-managed or go src git repositories.
##
remote_repository_url() {
  local host ghq_root go_src

  ghq_root=$(ghq root)
  go_src=$(echo $GOPATH/src)

  if [[ $PWD == *$ghq_root* ]]; then
    host=$(echo $(git rev-parse --show-toplevel) | sed -e "s:$ghq_root/::")
  elif [[ $PWD == *$go_src* ]]; then
    host=$(echo $(git rev-parse --show-toplevel) | sed -e "s:$go_src/::")
  else
    echo "Cannot open."
    return 0
  fi

  echo "https://$host"
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

##
# shows aws one-time credential
##
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

##
# shows profile list set in ~/.aws/credentials
##
aws_profiles() {
  local credential_file=~/.aws/credentials
  local profiles=()

  while read line; do
    if [[ $line =~ "\[(.*)\]" ]]; then
      profiles+=(${match[1]})
    fi
  done < $credential_file

  for i in $profiles; do
    echo $i
  done
}

get_private_ip() {
  aws ec2 describe-instances --profile $3 --instance-ids $(aws ecs describe-container-instances --profile $3 --cluster $1 --container-instances $(aws ecs describe-tasks --profile $3 --cluster $1 --tasks $(aws ecs list-tasks --profile $3 --cluster $1 --service-name $2 | jq -r '.taskArns[]') | jq -r '.tasks[].containerInstanceArn') | jq -r '.containerInstances[].ec2InstanceId') | jq -r '.Reservations[].Instances[].PrivateIpAddress'
}

get_service_name() {
  aws ecs list-services --profile $2 --cluster $1 | jq -r '.serviceArns[]' | awk -F "/" '{print $NF}' | fzf
}

get_cluster_name() {
  aws ecs list-clusters --profile $1 | jq -r '.clusterArns[]' | awk -F "/" '{print $NF}' | fzf
}

##
# shows procate ip address of ecs container instance
##
get_container_instance_private_ip () {
  local profile=$(aws_profiles | fzf)
  if [[ -z $profile ]]; then
    return 0;
  fi
  printf "AWS Profile: %s\n" $profile

  local cluster=$(get_cluster_name $profile)
  if [[ -z $cluster ]]; then
    return 0;
  fi
  printf "ECS Cluster: %s\n" $cluster

  local service=$(get_service_name $cluster $profile)
  if [[ -z $service ]]; then
    return 0;
  fi
  printf "ECS Service: %s\n" $service

  local ip=$(get_private_ip $cluster $service $profile)
  printf "Private IP (Container Instances):\n"
  echo $ip | awk '{ printf "- %s\n", $0 }'

  local region=$(aws configure get region --profile $profile)
  printf "\nhttps://%s.console.aws.amazon.com/ecs/home?region=%s#/clusters/%s/services/%s/details\n" $region $region $cluster $service
}

##
# shows record names registered in aws route53
##
list_route53_record_names () {
  local profile=$(aws_profiles | fzf)
  if [[ -z $profile ]]; then
    return 0;
  fi
  printf "AWS Profile: %s\n" $profile

  local hosted_zones=$(aws route53 list-hosted-zones --profile $profile | jq '.HostedZones[]')
  local zone_name=$(echo $hosted_zones | jq -r .Name | fzf)
  if [[ -z $zone_name ]]; then
    return 0;
  fi
  local zone_record=$(echo $hosted_zones | jq --arg name $zone_name 'select(.Name == $name)')
  local zone_id=$(echo $zone_record | jq -r '.Id')

  printf "Zone: %s (ID: %s)\n" $zone_name $zone_id
  local records=$(aws route53 list-resource-record-sets --profile $profile --hosted-zone-id $zone_id | jq '.ResourceRecordSets[]')
  local record_name=$(echo $records | jq -r '.Name' | fzf)
  echo $records | jq --arg name $record_name 'select(.Name == $name)'
}

function imdfind () {
  MDF_PREFIX="mdfind -onlyin $PWD "
  local result=$(FZF_DEFAULT_COMMAND=" find $PWD -type f" \
    fzf --bind "change:reload:$MDF_PREFIX {q}" \
        --ansi --phony --preview 'cat {}')
  echo $result
}

function irg () {
  RG_PREFIX="rg --no-heading --line-number --color=always --smart-case "
  local result=$(FZF_DEFAULT_COMMAND="$RG_PREFIX ''" \
    fzf --bind "change:reload:$RG_PREFIX {q} || true" \
        --ansi --phony)

  echo ${result%%:*}
}

function __image_name() {
  local image=$(docker image ls | fzf)
  local name=$(echo $image | awk '{print $1}')

  echo $name
}

function __image_id() {
  local image=$(docker image ls | fzf)
  local image_id=$(echo $image | awk '{print $3}')

  echo $image_id
}

function __container_id() {
  local container=$(docker container ls -a | fzf)
  local container_id=$(echo $container | awk '{print $1}')

  echo $container_id
}

function idocker() {
  local run_container="run_container"
  local stop_container="stop_container"
  local remove_container="remove_container"
  local remove_image="remove_image"
  local opt=$(printf "${run_container}\n${stop_container}\n${remove_container}\n${remove_image}" | fzf)

  case $opt in
    $run_container)
      local image=$(__image_name)
      local option="-itd"
      vared -p "Option (e.g., -it -p 8080:80 --rm): " option
      read "name?Container Name: "
      print -z "docker run $option --name $name $image"
      ;;
    $stop_container)
      local container=$(__container_id)
      print -z "docker container stop $container"
      ;;
    $remove_container)
      local container=$(__container_id)
      print -z "docker container rm $container"
      ;;
    $remove_image)
      local image=$(__image_id)
      print -z "docker image rm $image"
      ;;
    *)
      echo "command failed"
      return 1
  esac
}
