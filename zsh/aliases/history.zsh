history_count() {
	echo $(($(wc -l < $HISTFILE) + 1))
}

alias history_edit="nv $HISTFILE"

history_delete() {
	if [ -z "$1" ]; then
		LINE_NUMBER=$(history -50 | fzy | awk '{print $1}');
	else
		LINE_NUMBER=$1;
	fi

	if [ -z "$LINE_NUMBER" ]; then
	else
		sed -i "${LINE_NUMBER}d" $HISTFILE
		echo "Removed line $LINE_NUMBER of the history file";
	fi
}
