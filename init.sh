#!/bin/bash

repo_dir=$(pwd)
cd ~
home=$(pwd)
vim_file=/.vimrc
if test -f "${home}${vim_file}";then
	read -p "${home}${vim_file} exist! Overwrite it? yes/no" ans
	if [[ ${ans} == "yes" ]];then
	rm ${home}${vim_file}
	cp -s ${repo_dir}${vim_file} ${home}${vim_file}
	fi
else
	cp -s ${repo_dir}${vim_file} ${home}${vim_file}
fi
