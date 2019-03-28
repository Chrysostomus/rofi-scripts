#!/bin/dash
# A fuzzy file-finder and opener based on rofi 
# Requires: rofi, xdg-utils, nerdfonts
files=/tmp/.file_list

if [ -e $files ]; then
	# File list exist, use it
	input=$(cat $files | rofi -dmenu -p )
	# Update the list on the background
	find -type d -not -path '*/\.*' 2> /dev/null | sed -e 's/^\./:~/g' > /tmp/.file_list &
	find -not -type d 2> /dev/null | sed -E -e '/png$|jpg$|tiff$|gif$|jpeg$|bmp$/ s/^\./:~/g' -e '/mp3$|pcm$|wav$|aac$|ogg$|wma$/ s/^\./~/g' -e '/wmv$|webm$|m4v$|mkv$|mov$|flv$|avi$|mp4$/ s/^\./辶:~/g' -e 's/^\./:~/g' >> /tmp/.file_list & 
else
	# There is no file list, create it and show menu only after that
	find -type d -not -path '*/\.*' 2> /dev/null | sed -e 's/^\./:~/g' > /tmp/.file_list
	find -not -type d 2> /dev/null | sed -E -e '/png$|jpg$|tiff$|gif$|jpeg$|bmp$/ s/^\./:~/g' -e '/mp3$|pcm$|wav$|aac$|ogg$|wma$/ s/^\./~/g' -e '/wmv$|webm$|m4v$|mkv$|mov$|flv$|avi$|mp4$/ s/^\./辶:~/g' -e 's/^\./:~/g' >> /tmp/.file_list
	input=$(cat $files | rofi -dmenu -p )
fi
	case "$(echo $input | cut -d " " -f 1)" in
		a)
			exec $BROWSER https://wiki.archlinux.org/index.php/"$(echo $input | cut -d " " -f2-)" &> /dev/null &
			;;
		w)
			exec $BROWSER https://en.wikipedia.org/wiki/"$(echo $input | cut -d " " -f2-)" &> /dev/null &
			;;
		s)
			exec $BROWSER "https://startpage.com/do/search?query=$(echo $input | cut -d " " -f2-)&cat=web&pl=chrome&language=english" &> /dev/null &
			;;
		*)
			exec xdg-open "$(echo $input | sed 's/^....//g')" &> /dev/null &
			;;
	esac
