#!/bin/bash


#cd ~/ProjectAlice/core/nlu/model
cd ~/ProjectAlice/core/nlu/model
/usr/bin/git checkout SnipsNlu.py


# Only for the docker version
sed -i "s/.*import json/import os\nimport subprocess\nimport json/"  ./SnipsNlu.py

# For the all versions
#sed -i "s/.*tempTrainingData.rename(assistantPath)/# Changed by PS\n\t\t\tshutil.move(tempTrainingData, assistantPath)/"  ./SnipsNlu.py


# Only for the docker version
sed -i "27,33d" ./SnipsNlu.py


# Only for the docker version
cd ~/bin/SEDS
sed -i "s/.*def start(self):/\t# Indsat ny def start(self) og def stop(self)/" ~/ProjectAlice/core/nlu/model/SnipsNlu.py
sed -i "/\.*# Indsat ny def start(self) og def stop(self)/r ./replacement_texts/replace_SnipsNlu.txt" ~/ProjectAlice/core/nlu/model/SnipsNlu.py


# Line 177
sed -i "s/.*self.Commons.runRootSystemCommand(\['systemctl', 'restart', 'snips-nlu'\])/\t\t\tIndsæt replace_SnipsNlu2.txt/" ~/ProjectAlice/core/nlu/model/SnipsNlu.py

sed -i "/.*Indsæt replace_SnipsNlu2.txt/r ./replacement_texts/replace_SnipsNlu2.txt" ~/ProjectAlice/core/nlu/model/SnipsNlu.py

sed -i "177,177d" ~/ProjectAlice/core/nlu/model/SnipsNlu.py
