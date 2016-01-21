#!/bin/bash

# Install all the dotfiles in this directory (symlink them into place)
# When a file already exists, copy it to an "old_dotfiles" directory first
# When a symlink already exists, replace it

# All of these files go to '~/*'
declare -a dotfile_whitelist=(
  .bash_profile\
  .bash_includes\
  .gitconfig\
  .gitignore\
  .inputrc\
  .screenrc\
  .tmux.conf\
  .vim\
  .vimrc\
  .slate\
  .zshrc\
  .secretrc\
)

# Custom mapping of source to target link
# 1D array of [source1, target1, source2, target2 ... ]
declare -a custom_file_mappings=(
    "karabiner.xml" "${HOME}/Library/Application Support/Karabiner/private.xml" \
)
backup_dir="${HOME}/old_dotfiles"

function create_symlink {
  echo "created symlink: $2 -> $1"
  eval "ln -s '${1}' '${2}'"
}

function do_the_stuff {
    repo_filename=$1
    dotfile=$2
    repo_file=$(pwd)/${repo_filename}

    # if whitelisted file isn't actually in repo, skip
    if [ ! -f "${repo_file}" -a ! -d "${repo_file}" ]
    then
        continue
    fi

    # if file or dir exists, back it up then create symlink
    if [ -f "${dotfile}" -o -d "${dotfile}" ] && [ ! -h "${dotfile}" ]
    then
        if [ ! -d "${backup_dir}" ]
        then
            echo "WARN: made backup directory ${backup_dir}"
            mkdir "${backup_dir}"
        fi
        echo "WARN: moving existing ${dotfile} to ${backup_dir}" 1>&2
        mv "${dotfile}" "${backup_dir}"
        create_symlink "${repo_file}" "${dotfile}"
        continue
    fi

    # if symlink exists and is different, warn then create new symlink
    if [ -h "${dotfile}" ]
    then
        current_target=`eval "readlink '${dotfile}'"`
        if [ "${current_target}" != "${repo_file}" ]
        then
            echo "WARN: removed symlink: ${dotfile} -> ${current_target}" 1>&2
            rm "${dotfile}"
            create_symlink "${repo_file}" "${dotfile}"
        else
            echo "file ${dotfile} already set correctly" 1>&2
        fi
        continue
    fi

    # doesn't exist yet, create symlink
    if [ ! -a "${dotfile}" ]
    then
        create_symlink "${repo_file}" "${dotfile}"
        continue
    fi

}
cd `dirname $0`


for f in ${dotfile_whitelist[@]}; do
    # In the repo I don't include the leading dot so they're not all hidden
    if [[ $f =~ ^\. ]] 
    then
        repo_filename=${f:1}
    else
        repo_filename=${f}
    fi

    dotfile=${HOME}/.${repo_filename}

    do_the_stuff "${repo_filename}" "${dotfile}"
done

custom_mappings_len=`expr ${#custom_file_mappings[@]} - 1`
for i in $(seq 0 2 $custom_mappings_len); do
    i_plus=`expr ${i} + 1`
    do_the_stuff "${custom_file_mappings[$i]}" "${custom_file_mappings[${i_plus}]}"
done

