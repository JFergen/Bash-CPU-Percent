#! /bin/bash
# Joseph Fergen
# CSCE 3600.001 
# 9/22/2019
# Program that gets a percentage (1-99) from command line and outputs the current processes using more memory % than that number.

trap 'exit_program' INT

# Traps the first use of ^C before terminating the program on the 2nd ^C.
exit_program() {
	echo " (SIGINT) ignored. Enter ^C 1 more time to terminate the program."
	trap INT
}

# Stops program if no command-lines 
if [ $# -eq 0 ]
then
	echo 'Memory usage % parameter not specified. Aborting...';
	exit;
fi

# Checks to see if integer & within bounds. Exits if not.
if [ "$1" -eq "$1" ] && [ $1 -ge 1 ] && [ $1 -le 99 ]; then 
	while :
	do
		date;
		echo 'Processes occupying '$1'% or more system memory:';

		# Pipes the output of the three necessary columns into the awk filter command which only prints out processes using more memory than what was inputted
		ps -e -o pid=,user=,%mem= --sort -rss | awk -v awkMem=$1 '{ if ($3 >= awkMem) print $0"%" }'
		sleep 10;
	done
else
	echo "Memory usage parameter is not a valid integer percentage value";
	echo "[integer between 1 and 99]. Aborting...";
	exit;
fi
