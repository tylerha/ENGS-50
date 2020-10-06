#!/bin/bash
# A command that takes either no input or an optional [-q] input, which will print all files that end in .c and their line numbers as well as the total number of lines of all .c files if the [-q] is missing or will print just the total number of lines if it is present. If an input other then [-q] is present it should pring a usage statement.

Y=0
for f in *.c ; do
		X=$(cat ${f} | wc -l)
		let Y=X+Y
done


if [ $# == 0 ] ; then
		for f in *.c ; do
				wc -l ${f}
		done
		echo "Total ${Y}"
		exit
elif [ $# == 1 ] && [ $1 == "-q" ] ; then
		echo "Total ${Y}"
		exit
else
		echo "usage: codesize.sh [-q]"
fi

	 
		
		
