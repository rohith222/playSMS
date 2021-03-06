#!/bin/bash

PLAYSMS=$1

if [ -z "$PLAYSMS" ]; then
	echo "Usage: $0 <playSMS installation path>"
	exit 1
fi

cd $PLAYSMS
find . -type d -name "language" | sed -e "s/\/[^\/]*$//" > /tmp/.lang_folders
for i in `cat /tmp/.lang_folders` ; do
	for j in `ls -1 $i/language/ | grep '_'` ; do
		msgmerge $i/language/$j/LC_MESSAGES/messages.po $i/language/messages.pot
	done
done
