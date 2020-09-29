# docker-Alice-Linux-x86.
Let ProjectAlice run in a docker container.

I run it on a Ubuntu Destop.
I have only used it with Google ASR, fallback to Snips ASR and Amazon Polly TTS.

As this is work in progress. it will be a good idea to make an update occasionally after you have installed it or fiddle with it yourself.
```
"git stash"
"git stash clear"
"git pull"
```

Currently we check out b3 SHA 76948c48fa8a of Alice.
If you want to checkout a newer commit or latest after you have build the container and you have it up running, just cd into ProjectAlice and do:
```
"git stash"
"git stash clear"
"git checkout 1.0.0-b3"
"git pull"
```

Bla. bla bla

Read [Installing](#Installing) but be sure also to read [More](#more).

## Installing.
Have these three files in Your head from now. It will save you for troubles later on.
```
"config.json" "snips.toml" and `"googlecredentials.json"
```
Enter the following in a terminal:
- `"docker network create alice-nw"`
- `"git clone docker-Alice-Linux-x86"`
- cd into `"docker-Alice-Linux-x86/alice"`
- From now we call docker-Alice-Linux-x86/alice for just alice.
- Edit `Timezone.env` to your needs.
- cd into `"alice/misc"`
  - `"cp config.json.example config.json"`
  - Edit `config.json` for your needs.

- Remember
  - "awsAccessKey": "",
     "awsRegion": "eu-central-1",
     "awsSecretKey": "

- you can also just use your own, if you already have one working.<br>
    But be aware of settings "mqttHost": "mqtt",
"mqtt" means internal communication with docker mqtt, which is part of this repository.<br>
    if you use a diffent mqtt host edit `"config.json"` in alice/misc and  `"snips.toml"` in alice/Docker/host_volumes/config.<br>
    read [More](#more) section first.
- cp your `"googlecredentials.json"` to `"alice/misc/googlecredentials.json"`
  - For now we only use Google ASR with fallback to Snips ASR.
- cd into alice/Docker/host_volumes/config `"snips.toml.example snips.toml"`.
- cd back into alice root directory where the docker-compose.yml is.
  - Enter **`"bash build.sh"`**
    With `"bash build.sh"` you get the right UID and GID in the container.

- It will now build the images, on my Ubuntu it takes about 6-8 minutes from start to Alice is up and running.
- When finished building the images you enter `"docker-compose up -d"`.
  - You can use 1 or more terminals to enter the container.
    You must be in root  directory **alice**  and then enter `"docker-compose exec alice-amd bash"`.

  - After you have entered the container you can start ProjectAlice with `"start-alice"`.
    ```
    - Start: "start-alice"
    - Stop: "ctrl-c"
    - Exit out of container with "exit"
    - Pull down the container with "docker-compose down"
    ```
When you run the container manualy always use `"alice-start"` not `"venv/bin/python main.py".`

## More.
You can edit ``.
Under commands you can set different start commands.
```
# If using the mosquitto inside the container, is the same as starting it manually.
# You must then edit snips.toml and config.json accordingly.
# You must also uncomment "port 1883 of 1884" in docker-compose.yml.

#command: /usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf
#command: bash /start-scripts/start-alice-automatic.sh
command: bash /start-scripts/start-alice-manual.sh
```
During installation, command must be `command: bash /start-scripts/start-alice-manual.sh`

As you can see in the repository, there is also a companion mosquitto and nodered docker build.
Using them with docker-Alice-Linux-x86 is a good idea.
**Remember always start mosquitto before anything else also before installing Alice.**

Build "mosquitto" with `"bash build.sh"` then you get the right UID and GID in the container.
With "nodered" you just use `"nodered-start.sh"`
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

Inside the container where you run "start-alice" there are a few utilities eg.
In the /home/pi/bin, "retrain-all, retrain-single, reload.py, alice-start".

You can use `docker-compose exec alice-amd bash` in different ways eg.
- `docker-compose exec alice-amd bash -c "snips-watch -vvv"`

or viewing the log outside the container.
  - cd alice/Docker/host_volumes
  - tail -f ProjectAlice/var/logs/logs.log

like you do when you edit your skills from outside the container using the editor of your choice.
- cd alice/Docker/host_volumes/ProjectAlice/skills/YourSkill
- Edit YourSkill

To understand this container creation and build look inside the docker-compose.yml, Docker/host_volumes/start-scripts/- do_clone_alice.sh and
do_make_venv.sh

## Requirements.
[Docker](https://www.docker.com/) installed.

- `sudo curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh`

How to set up Docker to run without using sudo all the time.

 - `sudo usermod -aG docker $USER`

Log out and log in again to access the docker group.

Install of docker-compose:
-  sudo apt install -y libffi-dev \
  python3-venv python3-pip \
  && sudo pip3 install docker-compose

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

with "bind = "default@mqtt" the same as the Alice main unit you give her both mouth and ears. otherwise she"s pretty deaf-mute.

That"s that.

## Skills development
Todos:

Make a write about
: reloder.py
reloader.py is used to develop skills and other things much faster than normal stop/start of ProjectAlice.
What it does is monitor the folder (a watchdog) in which you are developing.
When a change occurs, for example you press save(ctrl-s) reloader.py will then automatically restart ProjectAlice. If it is a Dialog Template json you change, Alice will begin to retrain.
When you not develop to the web interface, it will pay off to set "webInterfaceActive": False in config.json
With out active web interface i takes on my machine about 0.9 seconds to restart ProjectAlice and about 14 seconds to retrain the 5 core skills.

Make a write about
: docker-compose.yml
  `- USE_PRE_BUILD_TGZ`
  - bla. bla
  - bla.bla

Not implemented.
  `- LANGUAGE_TRANSLATE=false`
  - Translate language.
Copy files from misc/language/[core/skills] dialog template en.json to the appropriate location.
The misc/... en.json can then contain the mixed eg. Danish and English text while in translation.
Make a tts polly that can handle {{lang:da-DK}} and possibly {{lang:en-US}}
Save in cache DK otherwise save in US/GB/AU.

My self I use the combination `docker-compose up; docker-compose down` in one terminal, and then further terminals for the other tasks.

## Troubleshooting.
The first time you ask Alice for something and you get the error below, then do a "ctrl-c" and a "alice-start".
Sometimes that error comes the first time you ask her to do something right after the installation.

`[MqttManager] Session "647b2527-e4b1-49e2-ad99-e166d9e09a3f" ended with an unrecoverable error: Receives error from component Nlu: { error: Cannot use unknown intent "greeting" in intents filter
, context: what time is it }`

## Reinstall.
If you want to reinstall ProjectAlice then delete  `alice/Docker/host_volumes/ProjectAlice`
If you have made changes to your skills, remember to save them first.
```
cd into alice root directory
rm -rf Docker/host_volumes/ProjectAlice
docker-compose up
```

## Experimental.
I am experimenting with a webcam mic and usb-speakers. Therefore there is a asound.conf in config.

## 📜 License.
docker-Alice-Linux-x86 ships under GPLv3, it means you are free to use and redistribute the code but are not allowed to use any part of it under a closed license.

Project Alice belongs to the [Project Alice Organisation](https://docs.projectalice.io/)

## Disclaimer.
I have made this repo for my self, so I am able to develop skills in an easy and quick way  and at the same time I can tamper with ProjectAlice.
 This is work in progress and the code is as it is.
 Use it at your own risk/fun.
