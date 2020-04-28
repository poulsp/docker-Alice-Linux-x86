#!/bin/bash

cd ~/ProjectAlice/system/manager/LanguageManager
/usr/bin/git checkout ~/ProjectAlice/system/manager/LanguageManager/strings.json

sed -i 's/\.*modulo/ modulo/' ~/ProjectAlice/system/manager/LanguageManager/strings.json

