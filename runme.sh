#!/bin/sh

/bin/echo -ne "Starting stock analysis"

mkdir -p ./csv

while read line
do
	perl ihub.pl "$line"
done <boardlist

echo "Done!"
