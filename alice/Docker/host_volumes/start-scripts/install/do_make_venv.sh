#!/bin/bash
clear
cd /home/pi/ProjectAlice
echo ''
echo '  +-------------------------------------------------------------+'
echo -e "  | \e[48;5;2m\e[38;5;228m                    Docker Alice x86                       \e[39m\e[49m |"
echo '  |-------------------------------------------------------------|'
echo -e '  |                                                             |'
echo "  |  Creating venv.                                             |"
echo '  |-------------------------------------------------------------|'
echo "  |                                                             |"
echo "  |  Takes a little time.                                       |"
echo '  +-------------------------------------------------------------+'
echo ''


python3 -m venv ./venv
venv/bin/pip install --upgrade pip

REQUIREMENTS_TEXT=$(cat <<'END_HEREDOC'
pyalsaaudio==0.8.4
python-dateutil==2.8.0
paho-mqtt==1.5.0
requests==2.21.0
esptool==2.8
pyserial==3.4
pydub==0.23.1
terminaltables==3.1.0
click==7.0
pyyaml==5.3
boto3==1.10.46
flask==1.1.1
flask-classful==0.14.2
flask-login==0.4.1
flask-socketio==4.2.1
googletrans==2.4.0
bcrypt==3.1.7
psutil==5.6.7
numpy==1.16.2
pyjwt==1.7.1
importlib_metadata==1.6.0
webrtcvad==2.0.10
snips-nlu==0.20.2
babel==2.7.0
google-cloud-speech==1.3.1
deepspeech==0.6.1
PyAudio
langdetect
watchdog

####
#new 2020-04-23
#PyAudio==0.2.11

#uninstall
#pyalsaaudio-0.8.4
END_HEREDOC
)

echo "$REQUIREMENTS_TEXT" > requirements.txt

venv/bin/pip install -r requirements.txt
venv/bin/python -m snips_nlu download en


~/bin/sed_all.sh
cd ~/ProjectAlice
venv/bin/python main.py


clear
echo ''
echo '  +-----------------------------------------------------------------------------------------------------------------+'
echo -e "  | \e[48;5;2m\e[38;5;228m                                             Docker Alice x86                                                  \e[39m\e[49m |"
echo '  |-----------------------------------------------------------------------------------------------------------------|'
echo -e '  |                                                                                                                 |'
echo "  |  Creation of venv finish!                                                                                       |"
echo "  | First time traning is acomplished. Congratulation!                                                            |"
echo "  |                                                                                                                 |"
echo "  |                                                                                                                 |"
echo "  | The message below are okay, here by the first training.                                                         |"
echo "  | Now you shall enter 'ctrl-c' followed by 'docker-composse down'.                                                |"
echo "  | The container are ready to use.                                                                                 |"
echo "  |                                                                                                                 |"
echo "  | [Project Alice]           An unhandled exception occured                                                        |"
echo "  |                                                                                                                 |"
echo "  | alice-amd    |   File \"/usr/local/lib/python3.7/subprocess.py\", line 512, in run                                |"
echo "  | alice-amd    |     output=stdout, stderr=stderr)                                                                |"
echo "  | alice-amd    | subprocess.CalledProcessError: Command '['pidof', 'snips-nlu']' returned non-zero exit status 1. |"
echo '  |-----------------------------------------------------------------------------------------------------------------|'
echo "  |                                                                                                                 |"
echo "  |  You can now run the container with:                                                                            |"
echo "  |    docker-compose up -d                                                                                         |"
echo "  |  And pull it down with:                                                                                         |"
echo "  |    docker-compose down                                                                                          |"
echo "  |                                                                                                                 |"
echo "  |  Go inside the container with 'docker-compose exec alice-amd bash'                                              |"
echo "  |  and 'alice'start'.                                                                                               |"
echo "  |                                                                                                                 |"
echo "  |  The system is now at your service.                                                                             |"
echo "  |  Good luck!                                                                                                     |"
echo '  +-------------------------------------------------------------------------------------------------------------- ---+'
echo ''

sleep 2
sudo kill -9 7
