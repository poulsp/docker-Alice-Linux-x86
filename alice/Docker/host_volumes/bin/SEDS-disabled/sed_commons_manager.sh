#!/bin/bash

cd ~/ProjectAlice/core/commons
/usr/bin/git checkout ~/ProjectAlice/core/commons/CommonsManager.py

sed -i "s/\.*return {slot\['slotName'\]\: slot\['rawValue'\] for slot in/return {slot['slotName']: slot['value']['value'] for slot in/"  ~/ProjectAlice/core/commons/CommonsManager.py

