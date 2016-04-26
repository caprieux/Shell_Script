#/bin/bash
NAME=$1
if [ "$NAME" == "" ];then
	NAME=`basename $PWD`
fi
echo $NAME

function clean_tags {
	rm -f tags
	rm -f *.tags
	rm -f cscope*
}

function generate_src_lists {
	case $1 in
		gg )
		;;
		* )
			echo "Use PWD as NAME"
	esac
}

function generate_ctags {

}

clean_tags
generate_src_lists $NAME
generate_ctags
generate_cscope

