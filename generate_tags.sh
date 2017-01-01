#/bin/bash

# Use this VIM functions for help quick load tags
#function! LoadMyTags(tagname)
#    let tagsFile = a:tagname . "_tags/" . a:tagname . ".tags"
#    let cscopeFile = a:tagname . "_tags/cscope.out"
#    exe "set tags+=" . tagsFile
#    exe "cs add " . cscopeFile
#endf


# Add your source files here
#================= src list functions start =================
function pwd_src_list {
	find `pwd` -maxdepth 1 -name "*.c" -or -name "*.h" -or -name "*.cpp" > $1
}
function show_all_modules {
	echo "no"
}
#================= src list functions start =================

functions call_for_help {
	echo "Usage: $0 module_name"
	show_all_modules
}

function clean_tags {
	if [ -d $1 ];then
		rm -rf $1
	fi
}

function generate_src_lists {
#make folder for save tags
	mkdir $2
	if [ ! -d $2 ];then
		echo "$2 dosen't exist!"
		exit
	fi
#generate source files list
	LIST_FILE=$2"/"$1".list"
	echo "Generate list file $LIST_FILE ..."
	case $1 in
		* )
			pwd_src_list $LIST_FILE
			;;
	esac
	echo "Done"
}

function generate_tags {
	LIST_FILE=$2"/"$1".list"
	TAGS_FILE=$2"/"$1".tags"
	if [ ! -s $LIST_FILE ];then
		echo "list file ($LIST_FILE) is empty or doesn't exist!"
		exit
	fi
	echo "Generate ctags ..."
	ctags -R -o $TAGS_FILE -L $LIST_FILE
	echo "Done"
	echo "Generate cscope ..."
	cscope -Rbq -i $LIST_FILE
	mv ./cscope* $2
	echo "DOne"
}

#main
NAME=$1
if [ "$NAME" == "" ];then
	NAME=`basename $PWD`
elif [ "$NAME" == "" ];then
	call_for_help $NAME
	exit
fi
PREFIX=""
FOLDER_NAME=$PREFIX$NAME"_tags"
echo "You are generating \"$NAME\" tags info. in \"$FOLDER_NAME\"."


clean_tags $FOLDER_NAME
generate_src_lists $NAME $FOLDER_NAME
generate_tags $NAME $FOLDER_NAME
ls $FOLDER_NAME

