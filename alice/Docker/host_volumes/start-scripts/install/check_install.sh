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
  if [ -z "$(ls -A -- '/home/pi/ProjectAlice')" ]; then
    bash /start-scripts/install/do_clone_alice.sh
  fi
fi


if [ ! -e /home/pi/ProjectAlice/config.py ]; then
  cp -af /misc/config.py /home/pi/ProjectAlice/config.py
fi


if [ ! -e /home/pi/ProjectAlice/credentials/googlecredentials.json ]; then
  cp -af /misc/googlecredentials.json /home/pi/ProjectAlice/credentials
fi


if [ ! -e /home/pi/ProjectAlice/var/cache/dialogTemplates/checksums.json ]; then
  mkdir -p /home/pi/ProjectAlice/var/cache/dialogTemplates
  echo '{}' > /home/pi/ProjectAlice/var/cache/dialogTemplates/checksums.json
fi


if [ ! -d /home/pi/ProjectAlice/venv ]; then
  bash /start-scripts/install/do_make_venv.sh

  exit 0
fi

