
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

#TODO uncomment git clone
cd /misc
git clone https://github.com/project-alice-assistant/ProjectAlice.git


cp -ar /misc/ProjectAlice /home/pi
#TODO uncomment #rm
rm -rf /misc/ProjectAlice

cd /home/pi/ProjectAlice
git stash \
&& git stash clear \
&& git clean -df \
&& git checkout 1.0.0-b1