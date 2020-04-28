#!/bin/bash

# Line: 104
cd ~/ProjectAlice/core/interface
/usr/bin/git checkout ~/ProjectAlice/core/interface/WebInterfaceManager.py

sed -i "s/\.*'host'.*\:.*self\.Commons\.getLocalIp()/# Changed by PS\n\t\t\t\t\t'host'\: '0.0.0.0'/"  ~/ProjectAlice/core/interface/WebInterfaceManager.py
