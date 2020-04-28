
START_TIME=`date +%s`

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
