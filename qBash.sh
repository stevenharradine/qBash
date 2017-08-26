#!/bin/bash
# (c) 2017 Steven Harradine
command=$1
input=$2

currentArgument=`head -n 1 "$input"`                                           # get the first element from the list
echo $($command "$currentArgument")                                            # execute command with argument
echo "$(tail -n +2 $input)" > $input                                           # delete top element from the list

if [[ ! ( "`head -n 1 $input`" == "" && "`cat $input | wc -l`" -eq 1 ) ]];then # if the list is not empty
	if [[ "`which qBash | wc -l`" -eq 1 ]];then                                # is this command installed?
		cmd="qBash"
	else                                                                       # or run from script
		cmd="./qBash.sh"
	fi
	
	$cmd "$1" $2                                                               # recursively execute this function with the same parameters
fi
