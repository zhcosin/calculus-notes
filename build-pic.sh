
#!/bin/bash

function scandir() {
    local cur_dir parent_dir workdir
    workdir=$1
    cd ${workdir}
    if [ ${workdir} = "/" ]
    then
	cur_dir=""
    else
	cur_dir=$(pwd)
    fi

    for dirlist in $(ls ${cur_dir})
    do
	if test -d ${dirlist};then
            echo "enter directory: "${dirlist}
	    cd ${dirlist}
	    scandir ${cur_dir}/${dirlist} $2
	    cd ..
	else
	    #做自己的工作
	    local filename=$dirlist
	    #echo "当前文件是："${cur_dir}/$filename
	    #echo ${#2} #.zip 4
	    #echo ${filename:(-${#2})}

	    if [[ ${filename:(-${#2})} = $2 ]]
	    then
		echo "process file:  "${cur_dir}/$filename
                asy -f pdf $filename
	    fi
	fi
    done
}

scandir $(pwd) "asy"
