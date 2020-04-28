
START_TIME=`date +%s`


if [ ! -e ./misc/config.py ]; then
  clear
  echo
  echo -e "  \033[41;5;2m\033[1;37;228m alice/misc/config.py dont exist  \033[0m"
  echo '  cd into alice/misc.'
  echo '  Copy config.py.example to config.py.'
  echo '  Edit config.py for your needs.'
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

docker-compose down >/dev/null 2>&1

echo
USERID=`id -u $"$USER"`
GROUPID=`id -g $"$USER"`
echo $"Your USERID: $USERID"
echo $"Your GROUPID: $GROUPID"
echo


#Is image builded
image=`docker image ls  -q poulsp/alice-amd | cat -`
if [  -z $image  ];then
  time docker build --build-arg UID=$"$USERID" --build-arg GID=$"$GROUPID"  -t poulsp/alice-amd -f Docker/Dockerfile .
fi


docker-compose up
docker-compose down

END_TIME=`date +%s`

TOTAL_RUN_TIME="Built at "$(((END_TIME-START_TIME)/60))" minutes."
echo '--------------------------'
echo "$TOTAL_RUN_TIME"
echo '--------------------------'
