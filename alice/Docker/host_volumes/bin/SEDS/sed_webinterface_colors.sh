#!/bin/bash

# Line: 104
cd ~/ProjectAlice/core/interface/static/css
/usr/bin/git checkout projectalice.css

sed -i "s/\.*\.logBlue { color\: blue; }/\.logBlue { color\: #00C0FF; }/"  ./projectalice.css

