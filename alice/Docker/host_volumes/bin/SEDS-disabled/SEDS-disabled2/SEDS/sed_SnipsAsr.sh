#!/bin/bash


cd ~/ProjectAlice/core/asr/model
/usr/bin/git checkout SnipsAsr.py

# Only for the docker version
sed -i "s/.*import time/import os\nimport subprocess\nimport time/"  ./SnipsAsr.py

sed -i "s/.*'libgfortran3'//"   ./SnipsAsr.py

sed -i "s/.*self.Commons.runRootSystemCommand(\['systemctl', 'start', 'snips-asr'\])/\t\tos.system(\"snips-asr \> \/dev\/null 2\>\&1 \&\")/" ./SnipsAsr.py

sed -i "s/.*self.Commons.runRootSystemCommand(\['systemctl', 'stop', 'snips-asr'\])/\t\tos.system(\"killall snips-asr \> \/dev\/null 2\>\&1 \&\")/" ./SnipsAsr.py

