#!/bin/bash

# Line 874
#exit

cd ~/ProjectAlice/core/interface/static/js
/usr/bin/git checkout common.js

#    let $nodal = $('#serverUnavailable');
#    let $nodal = $('#unKnown');

sed -i "s/\.*let \$nodal = \$('\#serverUnavailable');/\/\/ Changed by PS\n\t\tlet \$nodal = \$('\#unKnownAndDisabled');/" ./common.js


