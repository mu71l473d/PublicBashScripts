#!/bin/bash

#created by: Rene Bisperink
#version 1.0

#loop through the values and add them to the array
for ((x=1; x<$#; x++))
{
	#the echo is used for testing purposes
  echo "$x"
	#add the arguments to an array
  namesArray[x]="$x"
}

#pick a random number based on the number of arguments
randomNumber=$((( RANDOM % $# )  + 1 ))

#print the scapegoat!
echo "The scapegoat is: ${namesArray[$randomNumber]}"