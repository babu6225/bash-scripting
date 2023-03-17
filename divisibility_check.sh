#!/bin/bash
num=$1
if [ "$num"  -lt 10 ] && [ $((num % 3)) == 0 ];
then
                 echo "TOM" 
elif [ "$num" -lt 15 ] && [ $((num % 5)) == 0 ];
then
                echo "CAT"
elif [ $((num%15)) == 0 ];
then
   echo "TOMCAT"
fi   
