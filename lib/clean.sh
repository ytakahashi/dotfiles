#!/bin/bash

source lib/color.sh

SYMBOLIC_LINK="symbolic_link"
NORMAL_FILE="normal_file"
DIRECTORY="directory"
NOT_FOUND="not_found"

BK_DIR="${HOME}/.tmp"

mkdir -p ${BK_DIR}

check_file_type () {
  if [ -e ${1} ]; then
    if [ -d ${1} ]; then
      echo "${DIRECTORY}"
    else
      if [ -L ${1} ]; then
        echo "${SYMBOLIC_LINK}"
      else
        echo "${NORMAL_FILE}"
      fi
    fi
  else
      echo "${NOT_FOUND}"
  fi
}


remove_symbolic_link () {
  unlink ${1}
}

remove_normal_file () {
  mv ${1} ${BK_DIR}
}

remove_directory () {
  mv -r ${1} ${BK_DIR}
}

count_ok=0
count_changed=0


echo ""
echo "Clean **************************************"

for i in "$@"
do
  file_path="${HOME}/${i}"
  file_type=`check_file_type "${file_path}"`
  if [ ${file_type} == ${NOT_FOUND} ]; then
    ok "ok : [ ${i} ]"
    let ++count_ok
  else
    remove_"${file_type}" "${file_path}"
    changed "removed: [ ${file_path} ]"
    let ++count_changed
  fi
done

echo ""
echo "Play Recap *********************************"

ok "ok=${count_ok}"
changed "changed=${count_changed}"

