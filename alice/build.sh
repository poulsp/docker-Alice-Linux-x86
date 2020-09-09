
START_TIME=`date +%s`


if [ ! -d Docker/host_volumes/ProjectAlice ]; then
  mkdir -p Docker/host_volumes/ProjectAlice
fi


docker-compose down >/dev/null 2>&1


echo
USERID=`id -u $"$USER"`
GROUPID=`id -g $"$USER"`
echo $"Your USERID: $USERID"
echo $"Your GROUPID: $GROUPID"
echo


# -f for force build image
if [ "$1" == "-f" ];then
  BUILD_ARGS="--no-cache"
fi


#Is image builded
image=`docker image ls  -q poulsp/alice-amd | cat -`
if [[  -z $image  ||  ! -z $BUILD_ARGS ]];then
  time docker build $BUILD_ARGS --force-rm --build-arg UID=$"$USERID" --build-arg GID=$"$GROUPID"  -t poulsp/alice-amd -f Docker/Dockerfile .
fi


if [ -d Docker/host_volumes/ProjectAlice ] ; then
  if [ ! -z "$(ls -A Docker/host_volumes/ProjectAlice)" ]; then
    echo
    echo '  The directory Docker/host_volumes/ProjectAlice must be empty for successful installation.'
    echo '  Empty the directory.'
    echo
    exit 0
  fi

  owner=`stat -c '%U' Docker/host_volumes/ProjectAlice`
  if [ "$owner" == "$USER" ]; then
    echo
  else
    echo
    echo $"Wrong owner $owner"
    echo "  Docker/host_volumes/ProjectAlice are owned by $owner, remove Docker/host_volumes/ProjectAlice with sudo"
    echo '  sudo rm -r Docker/host_volumes/ProjectAlice'
    echo
    exit 0
  fi
fi


#if [ ! -e ./misc/config.py ]; then
if [ ! -e ./misc/config.json ]; then
  clear
  echo
  echo -e "  \033[41;5;2m\033[1;37;228m alice/misc/config.py dont exist  \033[0m"
  echo '  cd into alice/misc.'
  #echo '  Copy config.py.example to config.py.'
  echo '  Copy config.json.example to config.json.'
  echo '  Edit config.json for your needs.'
  echo
  exit 0
fi


if [ ! -e ./misc/googlecredentials.json ]; then
  clear
  echo
  echo -e "  \033[41;5;2m\033[1;37;228m alice/misc/googlecredentials.json dont exist!    \033[0m"
  echo '  Please place it in there.'
  echo '  For the moment this installation only support google ASR.'
  echo
  exit 0
fi

if [ ! -e ./Docker/host_volumes/config/snips.toml ]; then
  clear
  echo
  echo -e "  \033[41;5;2m\033[1;37;228m alice/Docker/host_volumes/config/snips.toml dont exist  \033[0m"
  echo '  cd into alice//Docker/host_volumes/config.'
  echo '  Copy snips.toml.example to snips.toml.'
  echo '  Edit snips.toml for your needs.'
  echo
  exit 0
fi

# start en watchdog evt.sæt et flag

docker-compose up
docker-compose down

END_TIME=`date +%s`

TOTAL_RUN_TIME="Built at "$(((END_TIME-START_TIME)/60))" minutes."
echo '--------------------------'
echo "$TOTAL_RUN_TIME"
echo '--------------------------'
