
START_TIME=`date +%s`

echo
USERID=`id -u $"$USER"`
GROUPID=`id -g $"$USER"`
echo $"Your USERID: $USERID"
echo $"Your GROUPID: $GROUPID"
echo


#Is image builded
image=`docker image ls  -q poulsp/mosquitto-amd | cat -`
if [  -z $image  ];then
  time docker build --build-arg UID=$"$USERID" --build-arg GID=$"$GROUPID"  -t poulsp/mosquitto-amd -f Docker/Dockerfile .
fi

END_TIME=`date +%s`

TOTAL_RUN_TIME="Built at "$(((END_TIME-START_TIME)/60))" minutes."
echo '--------------------------'
echo "$TOTAL_RUN_TIME"
echo '--------------------------'

