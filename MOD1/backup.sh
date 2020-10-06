#!/bin/bash

# Code that will backup any .c and .h files as well as any file named
# Makefile into a .backup directory (will create it if it doesn't
# exist). Will only backup a file if it doesn't already exist in the
# .backup directory. Prints "nothing to backup" if there is nothing to
# backup. If the [-q] marker is given as an argument only print a dot
# for every file that is backed up rather then the whole file name.


if [ ! -d .backup ] ; then
		mkdir .backup
fi

find *.c &> /dev/null
C=$?

find *.h &> /dev/null
H=$?

find Makefile &> /dev/null
M=$?

if [ ${C} == 1 ] && [ ${H} == 1 ] && [ ${M} == 1 ] ; then
		echo "nothing to backup"
		exit
fi

if [ $# == 0 ] ; then
		X=1
		if [ -e Makefile ] ; then
				for f in .backup/* ; do
						if cmp --quiet ${f} Makefile ; then
								let X=0
						fi
				done
				if [ ${X}	== 1 ] ; then
						cp Makefile .backup/Makefile.bak
						echo Makefile
				fi
		fi
		for s in *.c *.h ; do
				Y=1
				for f in .backup/* ; do
						if cmp --quiet ${f} ${s} ; then
								let Y=0
						fi
				done
				if [ ${Y} == 1 ] ; then
						cp ${s} .backup/${s}.bak
						echo ${s}
				fi
		done
		if [ ${X} == 0 ] && [ ${Y} == 0 ] ; then
				echo "nothing to backup"
				exit
		fi
elif [ $# == 1 ] && [ $1 == "-q" ] ; then
		X=1                                                                                                                                                                                                    
    if [ -e Makefile ] ; then                                                                                                                                                                              
        for f in .backup/* ; do                                                                                                                                                                            
            if cmp --quiet ${f} Makefile ; then                                                                                                                                                            
                let X=0                                                                                                                                                                                    
            fi                                                                                                                                                                                             
        done                                                                                                                                                                                               
        if [ ${X} == 1 ] ; then                                                                                                                                                                            
            cp Makefile .backup/Makefile.bak                                                                                                                                                              
            echo "."                                                                                                                                                                                
        fi                                                                                                                                                                                                 
    fi                                                                                                                                                                                                     
    for s in *.c *.h ; do                                                                                                                                                                                  
        Y=1                                                                                                                                                                                                
        for f in .backup/* ; do                                                                                                                                                                            
            if cmp --quiet ${f} ${s} ; then                                                                                                                                                                
                let Y=0                                                                                                                                                                                    
            fi                                                                                                                                                                                             
        done                                                                                                                                                                                               
        if [ ${Y} == 1 ] ; then                                                                                                                                                                            
            cp ${s} .backup/${s}.bak                                                                                                                                                                       
            echo "."                                                                                                                                                                                      
        fi                                                                                                                                                                                                 
    done                                                                                                                                                                                                   
    if [ ${X} == 0 ] && [ ${Y} == 0 ] ; then                                                                                                                                                               
        echo "nothing to backup"                                                                                                                                                                           
        exit                                                                                                                                                                                               
    fi                     
else
		echo "usage: backup.sh [-q]"
		exit
fi





