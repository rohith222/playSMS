#!/bin/bash

PLAYSMS=$1

if [ -z "$PLAYSMS" ]; then
	echo "Usage: $0 <playSMS installation path>"
	exit 1
fi

##Common strings
cd $PLAYSMS
touch plugin/language/messages.pot
find lib/ -iname "*.php" -exec xgettext --from-code=utf-8 -j -o plugin/language/messages.pot {} \;
find inc/ -iname "*.php" -exec xgettext --from-code=utf-8 -j -o plugin/language/messages.pot {} \;

##Themes,plugins and tools strings
cd $PLAYSMS
find . -type d -name "language" | grep -v "plugin/language" | sed -e "s/\/[^\/]*$//" > /tmp/.lang_folders
for i in `cat /tmp/.lang_folders` ; do touch "$i/language/messages.pot" ; done
for i in `cat /tmp/.lang_folders` ; do find $i -iname '*.php' -exec xgettext --from-code=utf-8 -j -o $i/language/messages.pot {} \; ; done
rm /tmp/.lang_folders
