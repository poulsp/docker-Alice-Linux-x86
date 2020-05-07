
clear
cd /home/pi
echo ''
echo '  +-------------------------------------------------------------+'
echo -e "  | \e[48;5;2m\e[38;5;228m                    Docker Alice x86                       \e[39m\e[49m |"
echo '  |-------------------------------------------------------------|'
echo -e '  |                                                             |'
echo "  |  Cloning ProjectAlice development edition                   |"
echo '  |-------------------------------------------------------------|'
echo "  |                                                             |"
echo '  +-------------------------------------------------------------+'
echo ''


# This file is for development of this repo only.
cd /misc
if [ ! -d /misc/ProjectAlice ] ; then
  git clone https://github.com/project-alice-assistant/ProjectAlice.git
fi


cp -ar /misc/ProjectAlice /home/pi


cd /home/pi/ProjectAlice
git stash \
&& git stash clear \
&& git clean -df \
&& git checkout 1.0.0-b1 \
&& git checkout -b working-341b3fe79b1bc 341b3fe79b1bc
# 341b3fe79b1bc are the last before change of audio-server and more
