#!/bin/bash

cd ~/ProjectAlice/core/asr/model
/usr/bin/git checkout ~/ProjectAlice/core/asr/model/GoogleASR.py

sed -i "s/\.*language_code=self.LanguageManager.activeLanguageAndCountryCode/language_code='en-GB'/" ~/ProjectAlice/core/asr/model/GoogleASR.py

