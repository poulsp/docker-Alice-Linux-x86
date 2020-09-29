
clear
cd /home/pi
echo ''
echo '  +-------------------------------------------------------------+'
echo -e "  | \e[48;5;2m\e[38;5;228m                    Docker Alice x86                       \e[39m\e[49m |"
echo '  |-------------------------------------------------------------|'
echo -e '  |                                                             |'
echo "  |  Cloning ProjectAlice                                       |"
echo '  |-------------------------------------------------------------|'
echo "  |                                                             |"
echo '  +-------------------------------------------------------------+'
echo ''

#TODO Remove only for test 2020-06-22
cd /misc
if [ ! -d /misc/ProjectAlice ] ; then
  git clone https://github.com/project-alice-assistant/ProjectAlice.git
fi


#TODO uncomment git clone
#cd /misc
#git clone https://github.com/project-alice-assistant/ProjectAlice.git


cp -ar /misc/ProjectAlice /home/pi

#rm -rf /misc/ProjectAlice

cd /home/pi/ProjectAlice
git stash \
&& git stash clear \
&& git clean -df \
&& git checkout 1.0.0-b3 \
&& git pull \
&& git stash clear \
&& git clean -df \
&& git checkout -b  76948c48fa8a-latest-workingb3 76948c48fa8a

