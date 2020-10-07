time /start-scripts/install/check_install.sh

sudo /bin/systemctl restart snapserver
~/bin/sed_all.sh
cd ~/ProjectAlice
venv/bin/python main.py
