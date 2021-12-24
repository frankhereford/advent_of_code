#!/bin/sh

count=0
while ./find_the_rabbit.pl $1; do
   printf '\nRun Count: %d\n' "$count"
   sleep 1
   (( count++ ))
done