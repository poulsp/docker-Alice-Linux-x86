# docker-Alice-Linux-x86.
Let ProjectAlice run in a docker container.
It's main goal is to have an ProjectAlice to develop skill and tamper with Alice core code in a fast and semi-automated development environment.

I run it on a Ubuntu Destop.
You can **only run it with** Google ASR, fallback to Snips ASR and Amazon Polly TTS for now.
As this is work in progress. it will be a good idea to make an update occasionally after you have installed it or fiddle with it yourself.
```
"git stash"
"git stash clear"
"git pull"
```
Currently we check out the master branch. The master branch is what formerly was 1.0.0-b4. It's fairly stable release.

If you want to checkout a newer branch, just cd into `host_volumes/ProjectAlice` and do:
```
"git stash"
"git stash clear"
"git checkout <branch>"
"e.g git checkout 1.0.0-b5"
"git pull"
```

Bla. bla bla

Read [Requirements](#Requirements), [Installing](#Installing) but be sure also to read [More](#more).

If you want to use audio input and output in the images then See  [Experimental](#Experimental).
## Installing.
Have these three files in your head from now. It will save you for troubles later on.
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
  - Edit `config.json` for your needs, **but only edit the setting there are capitalized** in the `config.json.example`.
- Remember
  - "awsAccessKey": "",
     "awsRegion": "eu-central-1",
     "awsSecretKey": "

    if you use a diffent mqtt host edit `"config.json"` in alice/misc and  `"snips.toml"` in alice/Docker/host_volumes/config.<br>
    read [More](#more) section first.
- cp your `"googlecredentials.json"` to `"alice/misc/googlecredentials.json"` **do not put it in** `config.json`
  - For now we only use Google ASR with fallback to Snips ASR.
- cd into alice/Docker/host_volumes/config `"cp snips.toml.example snips.toml"`.
  - edit `snips.toml`
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

To understand this container creation and build look inside the docker-compose.yml, Docker/host_volumes/start-scripts/- do_clone_alice.sh, do_make_venv.sh and build.sh.

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
To use a satellite.
The container can use mic and speaker. See [Experimental](#Experimental)

Alice first welcome you based on her creation of a new database.
It is best to start there with an old snips satellite.
But if you have installed a Alice satellite then use the following instruction.
Same procedure for the old snips satellite.
To install the old snips-satellite:
`wget https://raspbian.snips.ai/respeaker_iot/pool/s/sn/snips-satellite_0.64.0_armhf.deb`
`dpkg -i snips-satellite_0.64.0_armhf.deb`


ssh into the satellite.
sudo nano /etc/snips.toml and edit:

>
    [snips-common]
    mqtt = "<YOUR_DESKTOP_IP>:1883"

    [snips-audio-server]
    bind = "UUID-from-config.json@mqtt"

Then
>
    sudo systemctl stop ProjectAlice
    sudo systemctl restart snips-satellite
    sudo systemctl restart snips-skill-respeaker-sat.service or
    sudo systemctl restart hermesledcontrol.service

with "bind = "UUID-from-config.json@mqtt" the same as the Alice main unit you give her both mouth and ears. otherwise she"s pretty deaf-mute.

##### Using ProjectSatellite.
If you prefer to use ProjectAliceSatellite.
You simply use the text input widget, type "Add a satelite in the office" and it pairs. Then you have a fully working sats.
check /etc/snips.toml and ~/ProjectAlice/config.py: for the "UUID-from-config.json" from ProjectAlice master unit.

##### Troubleshooting ProjectSatellite.
If you use ProjectAliceSatellite then you should temporary insert `network_mode: "host"`and comment out the two lines starting with `networks:` in docker-compose.yml
```
    network_mode: "host"
    # networks:
    #   - alice-nw
```
otherwise there could be difficulties with the UDP broadcasting that Alice use to add new satellites. Restart container.

Once the satellite is set up and running then go back and comment out `network_mode: "host"` and restore `networks:` settings. Restart container.
Thanks to @Maniac.

That"s that.

## Skills development
Todos:

Make a write about
: reloder.py
reloader.py is used to develop skills and other things much faster than normal stop/start of ProjectAlice.
What it does is monitor the folder (a watchdog) in which you are developing.
When a change occurs, for example you press save(ctrl-s) reloader.py will then automatically restart ProjectAlice. If it is a Dialog Template json you change, Alice will begin to retrain.
When you not develop to the web interface, it will pay off to set "webInterfaceActive": false in config.json
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

I use the combination `docker-compose up; docker-compose down` in one terminal, and then further terminals for the other tasks.

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
I am experimenting with a webcam mic and usb-speakers. Therefore there is a asound.conf.example in Docker/host_volumes/config.
If you want to use it to run audio in and audio out on the host.
Set `"disableSoundAndMic": false` in config.json and copy asound.conf.example to asound.conf and edit it.


## 📜 License.
docker-Alice-Linux-x86 ships under GPLv3, it means you are free to use and redistribute the code but are not allowed to use any part of it under a closed license.

Project Alice belongs to the [Project Alice Organisation](https://docs.projectalice.io/)

## Disclaimer.
I have made this repo for my self, so I am able to develop skills in an easy and quick way  and at the same time I can tamper with ProjectAlice.
 This is work in progress and the code is as it is.
 Use it at your own risk/fun.


