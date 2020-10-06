#!/bin/bash
# 
# regress.sh - [insert purpose]
#
# usage: ./regress.sh
#
# input:
# output:
#
# assumptions:
#
# Tyler Hatch 
# 
# CHECK ARGUMENTS

if [ $# -lt 2 ]
then
    echo 1>&2 "usage: regress.sh dirname testfilename"
    exit 1
fi

for arg in "$@"
do
    if [ "$arg" != "$1" ] #If the input is not dirname
    then
        if [ ! -r "$arg" ] #If input2...inputn is not an existing, readable file
        then
            echo 1>&2 "$arg is not an existing, readable file"
            exit 1
        fi
    else #If the input is dirname
        if [ -f "$1" ] # If dirname exists, but is a file, not a directory
        then
            echo 1>&2 "$1 exists, but is not a directory"
            exit 1
        fi
    fi
done

# MAIN

daytime=$(date '+%Y%m%d%H%M%S' | sed 's/.\{8\}/&./')
currentDir=$(pwd)
shortCurrentDir=$(basename $(pwd))
mkdir $daytime

for arg in "$@"
do
    if [ "$arg" != "$1" ] # For each of the inputted tests
    then
        # Run test case with bash
        # Output three files below:
        # 1) copy of testfile
        cp $arg $currentDir/$daytime/$arg.test
        # 2) stdout and stderr from run
        bash $arg &> $currentDir/$daytime/$arg.output
                # 3) exit status of run
        echo $? > $currentDir/$daytime/$arg.status
       #        bash $arg >> $currentDir/$daytime/$arg.output 2>&1
    fi
done

if [ ! -d "$1" ]
then
        mv -T $daytime $1
        echo "saved test results in $shortCurrentDir/$1"
fi


if [ -d "$daytime" ]
then
        echo "saved test results in $daytime"
        echo "comparing $daytime with $1"
        diff $daytime $1 | grep Only
        for arg in "$@"
        do
                if [ "$arg" != "$1" ] # For each of the inputted tests
                then
                        filea1=$currentDir/$1/$arg.test
                        filea2=$currentDir/$daytime/$arg.test
                        fileb1=$1/$arg.status
                        fileb2=$daytime/$arg.status
                        filec1=$1/$arg.output
                        filec2=$daytime/$arg.output

                        diffTest=$(diff -q $filea1 $filea2)
                        diffStatus=$(diff -q $fileb1 $fileb2)
                        diffOutput=$(diff -q $filec1 $filec2)
                fi
        done
fi

# EXIT
exit 0
