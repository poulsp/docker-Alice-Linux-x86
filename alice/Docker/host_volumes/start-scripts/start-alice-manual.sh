
time /start-scripts/install/check_install.sh

echo
echo "Container Running."
echo "If started with 'docker-compose up' without detaching, press 'ctrl-c' to stop."
echo "'docker-compose down' for pull down of container."



# function control_c {
#     echo -en "\n## Caught SIGINT; Clean up and Exit \n"
#     #rm /var/run/myscript.pid
#     exit $?
# }

# trap control_c SIGINT
# trap control_c SIGTERM

# def terminateProcess(signalNumber, frame):
#   sys.exit()
# signal.signal(signal.SIGTERM, terminateProcess)
# signal.signal(signal.SIGINT, terminateProcess)


# # exit 0;

# _term() {
#   echo "Caught SIGTERM signal!"
# #  kill -TERM "$child" 2>/dev/null
# }


# trap: simple signal handling demo
# exit_on_signal_SIGINT () {
# #echo "Script interrupted." 2>&1
# echo "Script interrupted."
# sys.exit 0
# }
# exit_on_signal_SIGTERM () {
# #echo "Script terminated." 2>&1
# echo "Script terminated."
# sys.exit 0
# }
# trap exit_on_signal_SIGINT SIGINT
# trap exit_on_signal_SIGTERM SIGTERM

# echo "Doing some initial work...";
# #/bin/start/main/server --nodaemon &
# tail -f /dev/null


tail -f /dev/null
exit 0
