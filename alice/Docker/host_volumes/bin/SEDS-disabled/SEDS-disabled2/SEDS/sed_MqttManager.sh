#!/bin/bash


cd ~/ProjectAlice/core/server
/usr/bin/git checkout MqttManager.py

# About Line 898


# Only for the docker version
sed -i "899,907d" ./MqttManager.py

# Only for the docker version
cd ~/bin/SEDS
sed -i "s/.*def toggleFeedbackSounds(self, state='On'):/\t# Paste new def toggleFeedbackSounds(self, state='On'):/" ~/ProjectAlice/core/server/MqttManager.py
sed -i "/\.*# Paste new def toggleFeedbackSounds(self, state='On'):/r ./replacement_texts/replace_mqttManager.txt" ~/ProjectAlice/core/server/MqttManager.py

