#!/bin/bash

FILENAME=${1}
FILECOUNT=`echo ${FILENAME} | awk -F"_" '{print $1}' > ~/pattern.txt`
STRING=`grep -cf ~/pattern.txt ${FILENAME}`

FILENUMBER=`echo ${FILENAME} | awk -F"." '{print $1}' | awk -F"_" '{print $NF}'`
if [ ${FILENUMBER} -eq ${STRING} ]
then
	cp ./${FILENAME}  ./success 
   	
else
	cp ./${FILENAME}  ./fails
fi


