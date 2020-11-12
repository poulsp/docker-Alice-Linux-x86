#!/bin/bash


cd ~/ProjectAlice/core/server
/usr/bin/git checkout ~/ProjectAlice/core/server/AudioServer.py


sed -i "85,86d" ~/ProjectAlice/core/server/AudioServer.py




cd ~/bin/SEDS

sed -i "/super().onStop()/r ./replacement_texts/replace_audioServer.txt" ~/ProjectAlice/core/server/AudioServer.py
#sed -i "/.*super().onStop()/r ./replacement_texts/replace_SnipsNlu2.txt" ~/ProjectAlice/core/server/AudioServer.py

#sed -i "s/\.*\"What??\"//" ./AudioServer.py
#sed -i "/.*def onStop\(self\):/olsen stop/" ./AudioServer.py

#sed -i "/.*Indsæt replace_SnipsNlu2.txt/r ./replacement_texts/replace_SnipsNlu2.txt" AudioServer.py

#sed -i "/\.*# Paste new def toggleFeedbackSounds(self, state='On'):/r ./replacement_texts/replace_mqttManager.txt" ~/ProjectAlice/core/server/MqttManager.py

