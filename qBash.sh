#!/bin/bash
# (c) 2021 Steven Harradine
version=2.0.2
delay=0
command=""
input=""
help=""
update=""

for arg in "$@"; do
		key=`echo "$arg" | awk -F "=" '{print $1}'`
		value=`echo "$arg" | awk -F "=" '{print $2}'`

		if [[ $key == "--command" ]]; then
				command=$value
		elif [[ $key == "--inputFile" ]]; then
				input=$value
		elif [[ $key == "--delay" ]]; then
				delay=$value
		elif [[ $key == "--help" ]]; then
				help="me"
		elif [[ $key == "--update" ]]; then
				update="me"
		fi
done

if [[ $help != "" ]]; then
	echo "qBash Version $version"
	echo "executes bash commands passing in a variable from a queue."
	echo ""
	echo "Usage:"
	echo "**Note:** the input file is distructive, it is the queue and as items are popped off they are lost"
	echo "	./qBash.sh --command=echo --inputFile=queue.list --delay=0"
	echo "Where,"
	echo " * 'command' is the bash command to be executed"
	echo " * 'inputFile' is a line delimited file with the parameters to be appended to the end of the command"
	echo " * 'delay' (optional) is the amount of time to sleep between runs"
	echo " * 'help' displays this help screen"
	echo " * 'update' update qBash to the latest version"
	echo ""
elif [[ $update != "" ]]; then
	echo "Updating"
	installDir=`dirname "$0"`

	if [[ "$0" == *.sh ]];then                                # is this command NOT installed? (running via script)
		add_file_extension_fragment="add-sh-file-extention=true"
	fi

	curl https://raw.githubusercontent.com/stevenharradine/bashInstaller/master/installer.sh | bash -s program=qBash skip-ownership-and-permissions $add_file_extension_fragment "installDir=$installDir"
elif [[ $command == "" ]]; then
	echo "You must define 'command' argument"
elif [[ $input == "" ]]; then
	echo "You must define 'inputFile' argument"
else
	currentArgument=`head -n 1 "$input"`                                           # get the first element from the list
	bash -c "$command \"$currentArgument\""                                        # execute command with argument
	echo "$(tail -n +2 $input)" > $input                                           # delete top element from the list

	if [[ ! ( "`head -n 1 $input`" == "" && "`cat $input | wc -l`" -eq 1 ) ]];then # if the list is not empty
		if [[ "`which qBash | wc -l`" -eq 1 ]];then                                # is this command installed?
			cmd="qBash"
		else                                                                       # or run from script
			cmd="./qBash.sh"
		fi
		
		sleep $delay
		$cmd --command="$command" --inputFile=$input --delay=$delay                # recursively execute this function with the same parameters
	fi
fi
