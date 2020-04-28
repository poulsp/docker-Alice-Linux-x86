#!/bin/bash

# Line 157

cd ~/ProjectAlice/core/nlu/model
/usr/bin/git checkout SnipsNlu.py

sed -i "s/\.*tempTrainingData.rename(assistantPath)/# Changed by PS\n\t\t\tshutil.move(tempTrainingData, assistantPath)/"  ./SnipsNlu.py
