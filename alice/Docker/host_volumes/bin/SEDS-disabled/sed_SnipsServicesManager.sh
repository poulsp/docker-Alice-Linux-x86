#!/bin/bash


cd ~/ProjectAlice/core/snips
/usr/bin/git checkout ./SnipsServicesManager.py

cd ~/bin/SEDS
sed -i "s/\.*from pathlib import Path/# Changed by PS\nimport os\nimport subprocess\nfrom pathlib import Path/" ~/ProjectAlice/core/snips/SnipsServicesManager.py

sed -i "s/\.*result = aself.Commons.runRootSystemCommand(\['systemctl', cmd, service\])/# Changed by PS\nFjern denne linje og indsæt/" ~/ProjectAlice/core/snips/SnipsServicesManager.py

sed -i "s/\.*result = self.Commons.runRootSystemCommand(\['systemctl', cmd, service\])/Indsæt her/" ~/ProjectAlice/core/snips/SnipsServicesManager.py

sed -i "58,61d" ~/ProjectAlice/core/snips/SnipsServicesManager.py

sed -i "/.*Indsæt her/r ./replacement_texts/replace_SnipsServicesManager.txt" ~/ProjectAlice/core/snips/SnipsServicesManager.py

sed -i "s/\.*Indsæt her/# Changed by PS/" ~/ProjectAlice/core/snips/SnipsServicesManager.py
