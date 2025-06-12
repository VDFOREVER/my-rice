#!/usr/bin/env bash

if [ -z "$XDG_PICTURES_DIR" ]; then
	XDG_PICTURES_DIR="$HOME/Pictures"
fi

ScrDir=$(dirname "$(realpath "$0")")
swpy_dir="${XDG_CONFIG_HOME:-$HOME/.config}/swappy"
save_dir="${2:-$XDG_PICTURES_DIR/Screenshots}"
save_file=$(date +'%y%m%d_%Hh%Mm%Ss_screenshot.png')
temp_screenshot="/tmp/screenshot.png"

mkdir -p "$save_dir"
mkdir -p "$swpy_dir"
echo -e "[Default]\nsave_dir=$save_dir\nsave_filename_format=$save_file" > "$swpy_dir/config"

function print_error {
	cat <<"EOF"
    ./screenshot.sh <action>
    ...valid actions are...
        p  : full screen screenshot
        s  : select region to screenshot
        sf : frozen screen, then select region
        m  : focused output (monitor)
EOF
}

case $1 in
p) # full screen
	grim "$temp_screenshot" && swappy -f "$temp_screenshot"
	;;
s) # select region
	grim -g "$(slurp)" "$temp_screenshot" && swappy -f "$temp_screenshot"
	;;
sf) # frozen screen (simulate freeze with image buffer)
	grim "$temp_screenshot" && slurp | { read -r region && grim -g "$region" "$temp_screenshot" && swappy -f "$temp_screenshot"; }
	;;
m) # focused output
	output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused==true).name')
	grim -o "$output" "$temp_screenshot" && swappy -f "$temp_screenshot"
	;;
*) # invalid
	print_error
	exit 1
	;;
esac

if [ -f "${save_dir}/${save_file}" ]; then
	save_dir_pretty="${save_dir/$HOME/~}"
	notify-send -a "Screenshot" -i "${save_dir}/${save_file}" "Saved to ${save_dir_pretty}"
fi
