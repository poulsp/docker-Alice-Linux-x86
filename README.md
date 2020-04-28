# docker-Alice-Linux-x86.
Let ProjectAlice run in a docker container.

I run it on a Ubuntu Destop.
I have only used it with Google ASR and Amazon Polly TTS.

Bla. bla bla

Read Installing but be sure also to read [More](#more).

## Installing.
Enter following:
- `docker network create alice-nw`
- `git clone docker-Alice-Linux-x86`
- cd into `docker-Alice-Linux-x86/alice`
- From now we call docker-Alice-Linux-x86/alice for root.
- Edit `Timezone.env` to your needs.
- cd into `root/misc`
  - `cp config.py.example config.py`
  - Edit `config.py` for your needs.
  - you can also just use your own, if you already have one working.<br>
    But be aware of settings "mqttHost": "mqtt",   
    "mqtt" means internal communication with docker mqtt.<br>
    if you use a diffent mqtt host edit `'config.py'` and  `'snips.toml'` in root/Docker/host_volumes/config.<br>
    read [More](#more) section first.
- cp your `googlecredentials.json to` `root/misc/googlecredentials.json`
  - For now we only use Google ASR
- cd to root directory where the docker-compose.yml is.
  - Enter `bash install.sh`
    With `bash install.sh` you get the right UID and GID in the container.

- It will now build the images, on my Ubuntu it takes about 6-8 minutes from start to Alice is up and running.
- When finished building the images you enter `docker-compose up -d`.
  - You can use 1 or more terminals to enter the container.
    You must be in 'root' and then enter `docker-compose exec alice-amd bash`.

  - After you have entered the container you can start ProjectAlice with `'start-alice'`.
    ```
    - Start: 'start-alice'
    - Stop: 'ctrl-c'
    - Exit out of container with 'exit'
    - Pull down the container with 'docker-compose down'
    ```
When you run the container manualy always use `'alice-start'` not `'venv/bin/python main.py'.`


## More.
You can edit `docker-compose.yml`.
Under commands you can set different start commands.
```
# If using the mosquitto inside the container.
# You must then edit snips.toml and config.py accordingly.
#command: /usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf
#command: tail -f /dev/null
#command: bash /start-scripts/start-alice-automatic.sh
command: bash /start-scripts/start-alice-manual.sh
```
During installation, command must be `command: bash /start-scripts/start-alice-manual.sh`

As you can see in the repository, there is also a companion mosquitto and nodered docker build.
Using them with docker-Alice-Linux-x86 is a good idea. They then communicate on an internal network, while you also can reach them from the outside.
**Remember always start mosquitto before anything else also before installing Alice.**

Build 'mosquitto' with `bash install.sh` then you get the right UID and GID in the container.
With 'nodered' you just use `nodered-start.sh`
Remember to edit Timezone.env to you needs for both.
You can start/stop them with
  ```
  mosquitto-start.sh mosquitto-stop.sh
  nodered-start.sh nodered-stop.sh
  ```
Possibly create a symbolic link to your ~/bin
They are placed in docker-Alice-Linux-x86/mosquitto and docker-Alice-Linux-x86/node-red.
Place yourself in the directory mosquitto/nodered
```
ln -s $(pwd)/mosquitto-start.sh  ~/bin/mosquitto-start.sh
ln -s $(pwd)/mosquitto-stop.sh  ~/bin/mosquitto-stop.sh
ln -s $(pwd)/nodered-start.sh  ~/bin/nodered-start.sh
ln -s $(pwd)/nodered-stop.sh  ~/bin/nodered-stop.sh
```

Inside the container where you run 'start-alice' there are a few utilities eg.
In the /home/pi/bin, "retrain-all, retrain-single, reload.py, alice-start".

You can use `docker-compose exec alice-amd bash` in different ways eg.
- `docker-compose exec alice-amd bash -c 'snips-watch -vvv'`

or viewing the log outside the container.
  - cd root/Docker/host_volumes
  - tail -f ProjectAlice/var/logs/logs.log

like you do when you edit your skills.
- cd root/Docker/host_volumes/ProjectAlice/skills/YourSkill
- Edit YourSkill

## Requirements.
[Docker](https://www.docker.com/) installed.

- `sudo curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh`

How to set up Docker to run without using sudo all the time.

 - `sudo usermod -aG docker $USER`

Log out and log in again to access the docker group.


## Satellite.
The container are without mic and speaker.
So you have to use a satellite.

Alice first welcome you based on her creation of a new database.
It is best to start there with an old snips satellite.
But if you have installed a Alice satellite then use the following instruction.
Same procedure for the old snips satellite.

ssh into the satellite.
sudo nano /etc/snips.toml and edit:

>
    [snips-common]
    mqtt = "<YOUR_DESKTOP_IP>:1883"

    [snips-audio-server]
    bind = "default@mqtt"

Then
>
    sudo systemctl stop ProjectAlice
    sudo systemctl restart snips-satellite
    sudo systemctl restart snips-skill-respeaker-sat.service or
    sudo systemctl restart hermesledcontrol.service

with 'bind = "default@mqtt"' the same as the Alice main unit you give her both mouth and ears. otherwise she's pretty deaf-mute.

That's that.

## Troubleshooting.
The first time you ask Alice for something and you get the error below, then do a 'ctrl-c' and a 'alice-start'.
Sometimes that error comes the first time you ask her to do something right after the installation.

`[MqttManager] Session "647b2527-e4b1-49e2-ad99-e166d9e09a3f" ended with an unrecoverable error: Receives error from component Nlu: { error: Cannot use unknown intent 'greeting' in intents filter
, context: what time is it }`

## Reinstall.
If you want to reinstall Alice then delete every thing in `root/Docker/host_volumes/ProjectAlice/*`

As a precaution do
```
cd into root directory
rm -rf Docker/host_volumes/ProjectAlice/*
rm -rf Docker/host_volumes/ProjectAlice/.*
mkdir -p Docker/host_volumes/ProjectAlice
touch Docker/host_volumes/ProjectAlice/alice-not-installed
docker-compose up
```
The root/Docker/host_volumes/ProjectAlice directory  with the file 'alice-not-installed' is mandatory for the installation to work.

## 📜 License.
docker-Alice-Linux-x86 ships under GPLv3, it means you are free to use and redistribute the code but are not allowed to use any part of it under a closed license.

Project Alice belongs to the [Project Alice Organisation](https://docs.projectalice.io/)

## Disclaimer.
This is work in progress. Use it at your own risk.

