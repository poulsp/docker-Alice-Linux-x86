#!/bin/bash

cd ~/ProjectAlice

sed -i 's/\.*"useHLC": True/"useHLC": False/' ~/ProjectAlice/config.py

#sed -i 's/\.*"probabilityThreshold": 0.5/"probabilityThreshold": 0.343/' ~/ProjectAlice/config.py

#sed -i 's/\.*"skillAutoUpdate": True/"skillAutoUpdate": False/' ~/ProjectAlice/config.py

sed -i 's/\.*"debug": False/"debug": True/' ~/ProjectAlice/config.py

sed -i 's/\.*"devMode": False/"devMode": True/' ~/ProjectAlice/config.py

#sed -i 's/"ttsLanguage": "en-US"/"ttsLanguage": "en-GB"/' ~/ProjectAlice/config.py

#sed -i 's/"ttsType": "male"/"ttsType": "female"/'
#sed -i 's/"ttsType": "female"/"ttsType": "male"/'

#sed -i 's/"ttsVoice": "Joanna"/"ttsVoice": "Amy"/' ~/ProjectAlice/config.py

