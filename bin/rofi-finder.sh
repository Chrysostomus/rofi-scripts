#!/bin/zsh
# A fuzzy file-finder and opener based on rofi 
# Requires: rofi, xdg-utils, nerdfonts

files=$(find -type d -not -path '*/\.*' 2> /dev/null | sed -e 's/^\./:~/g'
find -not -type d 2> /dev/null | sed -E -e '/png$|jpg$|tiff$|gif$|jpeg$|bmp$/ s/^\./:~/g' -e '/mp3$|pcm$|wav$|aac$|ogg$|wma$/ s/^\./~/g' -e '/wmv$|webm$|m4v$|mkv$|mov$|flv$|avi$|mp4$/ s/^\./辶:~/g' -e 's/^\./:~/g')

input=$(echo $files | rofi -dmenu -p :) 
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
