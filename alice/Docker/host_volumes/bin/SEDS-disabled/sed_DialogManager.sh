#!/bin/bash

cd ~/ProjectAlice/core/dialog
/usr/bin/git checkout DialogManager.py

# Remove the annoying was that what you mean before, where she think she understand me.
# about line 108
LINE_NO="$(cut -d':' -f1 <<< $(grep -rnh 'if session.isEnding or session.isNotification:' ./DialogManager.py))"
L1=$(expr $LINE_NO + 1)
L2=$(expr $L1 + 3)
L3="$L1"",""$L2""d"

sed -i "$L1"",""$L2""d" ./DialogManager.py

