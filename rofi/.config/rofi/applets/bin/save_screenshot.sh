#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Screenshot

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Theme Elements
prompt='Screenshot'
mesg="Saving screenshot for MD insertion."

if [[ "$theme" == *'type-1'* ]]; then
	list_col='1'
	list_row='5'
	win_width='400px'
elif [[ "$theme" == *'type-3'* ]]; then
	list_col='1'
	list_row='5'
	win_width='120px'
elif [[ "$theme" == *'type-5'* ]]; then
	list_col='1'
	list_row='5'
	win_width='520px'
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
	list_col='5'
	list_row='1'
	win_width='670px'
fi

# Options
layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
	option_1=" Capture Desktop"
	option_2=" Capture Area"
	option_3=" Capture Window"
	option_4=" Capture in 5s"
	option_5=" Capture in 10s"
else
	option_1=""
	option_2=""
	option_3=""
	option_4=""
	option_5=""
fi

# Rofi CMD
rofi_cmd () {
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-markup-rows \
		-theme ${theme} \
		-mesg "${mesg}"
}

# Pass variables to rofi dmenu
run_rofi () {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

# Screenshot
base_dir=$1

# Make sure base_dir ends with /
case "$base_dir" in
	*/)
		;;
	*)
		base_dir=$base_dir/
esac


# Show the save dialog
show_save_dialog () {
	file=$(zenity --file-selection --save --modal --file-filter *.png --filename $base_dir)

	# If file ends in .png, output as is
	# If it doesnt, output with a .png
	case $file in
		*.png)
			echo $file;;
		*)
			echo $file.png;;
	esac
}

# notify and view screenshot
notify_view () {
	notify_cmd_shot='dunstify -u low --replace=699'
	${notify_cmd_shot} "Copied to clipboard."
	if [[ -e "$1" ]]; then
		${notify_cmd_shot} "Screenshot Saved."
	else
		${notify_cmd_shot} "Screenshot Deleted."
	fi
}

# Copy screenshot to clipboard
copy_shot () {
	tee "$1"
	echo ![]\(/${1#"$base_dir"}\) | xclip -selection clipboard
}

# countdown
countdown () {
	for sec in `seq $1 -1 1`; do
		dunstify -t 1000 --replace=699 "Taking shot in : $sec"
		sleep 1
	done
}

# take shots
shotnow () {
	file=$(show_save_dialog)
	sleep 0.5 && maim -u -f png | copy_shot $file
	notify_view $file
}

shot5 () {
	file=$(show_save_dialog)
	countdown '5'
	sleep 1 && maim -u -f png | copy_shot $file
	notify_view $file
}

shot10 () {
	file=$(show_save_dialog)
	countdown '10'
	sleep 1 && maim -u -f png | copy_shot $file
	notify_view $file
}

shotwin () {
	file=$(show_save_dialog)
	maim -u -f png -i `xdotool getactivewindow` | copy_shot $file
	notify_view $file
}

shotarea () {
	file=$(show_save_dialog)
	maim -u -f png -s -b 2 -c 0.35,0.55,0.85,0.25 -l | copy_shot $file
	notify_view $file
}

# Execute Command
run_cmd () {
	if [[ "$1" == '--opt1' ]]; then
		shotnow
	elif [[ "$1" == '--opt2' ]]; then
		shotarea
	elif [[ "$1" == '--opt3' ]]; then
		shotwin
	elif [[ "$1" == '--opt4' ]]; then
		shot5
	elif [[ "$1" == '--opt5' ]]; then
		shot10
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
    $option_5)
		run_cmd --opt5
        ;;
esac


