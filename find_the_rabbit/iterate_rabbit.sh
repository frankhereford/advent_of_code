#!/bin/sh

count=0
while ./find_the_rabbit.pl --holes $1; do
   printf '\nRun Count: %d\n' "$count"
   sleep $2
   (( count++ ))
done