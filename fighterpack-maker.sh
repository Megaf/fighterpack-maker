#!/bin/sh

# fighterpack-maker.sh by Megaf (https://github.com/Megaf)
# This script will download aircraft, or stuff from Git and copy them to where $dst is set.

dst="$HOME/Downloads/Aircraft" tmp="$HOME/Downloads/tmp_downloads" # Where things will be downloaded to

# FUNCTIONS
cln_var() {
    unset target url branch from # clearing variables
}

clone() { # Download using git
    echo "=> CHECKING IF $target IS PRESENT."
    if [ -d "$target" ]; # Check if repo was already downloaded
        then
            echo "=> IT WAS FOUND! UPDATING IT."
            cd "$target" && git pull # If it was, then update it
        else
            echo "=> IT WAS NOT FOUND. DOWNLOADING IT!"
            echo "=> DOWNLOADING BRANCH $branch FROM $url TO $target"
            git clone -b $branch --depth=1 --single-branch "$url" "$target" # Otherwise, do a git clone
    fi
}

sync() {
    echo "=> COPYING $from TO $dst"
    rsync -a "$from" "$dst/" # Move aircraft from original repo to $dst
}

# END OF FUNCTIONS
clear # Clear the screen.
echo "" # Prints empty line
# Welcome message
echo "=> WELCOME TO FIGHTERPACK-MAKER! By Megaf"
echo ""

echo "=> CREATING $dst and $tmp."
mkdir -p "$dst" "$tmp" # Creates destination/download directories.
echo ""

echo "=> CLEARING ROGUE VARIABLES."
cln_var # Unset previously set variables if they are set for some reason
echo ""

# F-14 and F-15 Section
echo "========="
echo "=> F-14"
target="$tmp/zaretto" branch="develop" url="git@github.com:Zaretto/fg-aircraft.git"
clone
from="$target/aircraft/f-14b"
sync && unset from
echo ""
echo "========="
echo "=> F-15"
from="$target/aircraft/F-15"
sync && cln_var

# Mirage 2000
echo ""
echo "========="
echo "=> MIRAGE-2000"
target="$tmp/5H1N0B1" branch="master" url="git@github.com:5H1N0B11/flightgear-mirage2000.git"
clone
from="$target/Mirage-2000"
sync && cln_var

# Viggen
echo ""
echo "=========="
echo "=> VIGGEN"
target="$tmp/Nikolai" branch="master" url="git@github.com:NikolaiVChr/flightgear-saab-ja-37-viggen.git"
clone
from="$target/Aircraft/JA37"
sync && cln_var
