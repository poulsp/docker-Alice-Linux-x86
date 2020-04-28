#!/bin/bash


if [ ! -e /misc/config.py ]; then
  echo
  echo 'alice/misc/config.py dont exist!'
  echo 'cd into alice/misc.'
  echo 'Copy config.py.example to config.py.'
  echo 'Edit config.py for your needs.'
  echo
  exit 0
fi


if [ ! -e /misc/googlecredentials.json ]; then
  echo
  echo 'alice/misc/googlecredentials.json dont exist!'
  echo 'Please place it in there.'
  echo 'For the moment this installation only support google ASR.'
  exit 0
  echo
fi


if [ -d /home/pi/ProjectAlice ]; then
  owner=`stat -c '%U' /home/pi/ProjectAlice`
  if [ "$owner" == "root" ]; then
    echo '  /home/pi/ProjectAlice are owned by root, pull down the container and remove alice/Docker/host_volumes/ProjectAlice with sudo.'
    echo '  and then mkdir -p  alice/Docker/host_volumes/ProjectAlice.'
  else
    # if [ -z "$(ls -A -- '/home/pi/ProjectAlice')" ]; then
    if [ -e /home/pi/ProjectAlice/alice-not-installed ]; then
      bash /start-scripts/install/do_clone_alice.sh
      rm -f /home/pi/ProjectAlice/alice-not-installed
    fi
  fi
fi


if [ ! -e /home/pi/ProjectAlice/config.py ]; then
  cp -af /misc/config.py /home/pi/ProjectAlice/config.py
fi


if [ ! -e /home/pi/ProjectAlice/credentials/googlecredentials.json ]; then
  cp -af /misc/googlecredentials.json /home/pi/ProjectAlice/credentials
fi


if [ ! -e /home/pi/ProjectAlice/assistant ]; then
  cd /home/pi/ProjectAlice
  ln -sfn  trained/assistants/assistant_en assistant
fi


if [ ! -e /home/pi/ProjectAlice/var/cache/dialogTemplates/checksums.json ]; then
  mkdir -p /home/pi/ProjectAlice/var/cache/dialogTemplates
  echo '{}' > /home/pi/ProjectAlice/var/cache/dialogTemplates/checksums.json
fi


if [ ! -e /home/pi/ProjectAlice/venv ]; then
  # Install venv
  bash /start-scripts/install/do_make_venv.sh
  cp -af /misc/config.py /home/pi/ProjectAlice/config.py
  cp -af /misc/googlecredentials.json /home/pi/ProjectAlice/credentials
  exit 0
fi
