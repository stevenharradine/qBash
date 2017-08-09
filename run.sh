#!/bin/bash
command=$1
input=$2

# get the first element from the list
currentArgument=`head -n 1 "$input"`

# execute command with argument
echo $($command "$currentArgument")

# delete top element from the list
echo "$(tail -n +2 $input)" > $input

# if the list is not empty
if [[ ! ( "`head -n 1 $input`" == "" && "`cat $input | wc -l`" -eq 1 ) ]]; then
	# recursively execute this function with the same parameters
	./run.sh "$1" $2
fi
