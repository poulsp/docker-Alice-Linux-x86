#!/bin/bash

# Temporary workaround to stop alice hearing her self, when we use satellites,


cd ~/ProjectAlice/system/manager/TalkManager/talks
/usr/bin/git checkout ~/ProjectAlice/system/manager/TalkManager/talks/en.json


sed -i "s/\.*\"What??\"//" ~/ProjectAlice/system/manager/TalkManager/talks/en.json
sed -i "s/\.*\"Sorry? Can you repeat?\",//" ~/ProjectAlice/system/manager/TalkManager/talks/en.json
sed -i "s/\.*\"I did not understand what you want\",/\"I did not understand what you want\"/" ~/ProjectAlice/system/manager/TalkManager/talks/en.json

