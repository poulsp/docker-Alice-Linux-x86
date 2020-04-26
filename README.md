# docker-Alice-Linux-x86.
Let ProjectAlice run in a docker container.

Bla. bla bla
Read Installing but be sure also to read [More](#more).

## Installing.
- `git clone docker-Alice-Linux-x86`
- cd into docker-Alice-Linux-x86/alice
- From now we call docker-Alice-Linux-x86/alias for root.
- Edit Timezone.env to your needs.
- cd into root/misc
  - cp config.py.example config.py
  - Edit config.py for your needs.
- cp your googlecredentials.json to root/misc/googlecredentials.json
  - We use Google ASR
- cp snips.toml.example into root/Docker/host_volumes/config/snips.toml.
- cd to root folder where the docker-compose.yml is.
  - Enter `time bash install.sh`

- It will now build the images, on my Ubuntu it takes about 6-8 minutes from start to Alice is up and running.
- When finished building the images you enter `docker-compose up -d`.
  - You can use 1 or more terminals to enter the container.
    You must be in root and then enter `docker-compose exec alice-amd bash`.

  - After you have entered the container you can start ProjectAlice with `"start-alice"`.
  - Stop "start-alice" with `ctrl-c`
  - Exit out of container with `exit`
  - Pull down the container with `docker-compose down`

When you run the container manualy always use 'alice-start' not 'venv/bin/python main.py'.

## More.
You can edit docker-compose.yml.
Under commands you can set different start commands.
- #command: /usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf #use mosquitto inside the container
- #command: tail -f /dev/null
- #command: bash /start-scripts/start-alice-automatic.sh
- command: bash /start-scripts/start-alice-manual.sh

During installation, command must be `command: bash /start-scripts/start-alice-manual.sh`

As you can see in the repository, there is also a mosquitto and node red docker build info.
Using them with docker-Alice-Linux-x86 is a good idea.
Remember always start mosquitto before anything else also before installing Alice.
You can start/stop them with
  `mosquitto-start.sh` `mosquitto-stop.sh`
  `nodered-start.sh` `nodered-stop.sh`
They are places in docker-Alice-Linux-x86/node-red and docker-Alice-Linux-x86/mosquitto.

Inside the container where you run 'start-alice' there are a few utilities eg.
In the /home/pi/bin, "retrain-all, retrain-single, reload.py, alice-start".

You can use `docker-compose exec alice-amd bash` in different ways eg.
- `docker-compose exec alice-amd bash -c 'snips-watch -vvv'`

and viewing the log outside the container.
  - cd root/Docker/host_volumes
  - tail -f ProjectAlice/var/logs/logs.log

Like you do when you edit your skills.
- cd root/Docker/host_volumes/ProjectAlice/skills
- Edit yourSkill

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
Same procedure for the old snips satellite

ssh into the satellite.
sudo joe /etc/snips.toml and edit:

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

with 'bind = "default @ mqtt"' the same as the Alice head you give her both mouth and ears. otherwise she's pretty deaf-mute.

That's that.

## Troubleshooting.
The first time you ask Alice for something and you get the error below, then do a 'ctrl-c' and a 'alice-start'.
Sometimes that mistake comes the first time you ask her something right after the installation.

`[MqttManager] Session "647b2527-e4b1-49e2-ad99-e166d9e09a3f" ended with an unrecoverable error: Receives error from component Nlu: { error: Cannot use unknown intent 'greeting' in intents filter
, context: what time is it }`

## 📜 License.
docker-Alice-Linux-x86 ships under GPLv3, it means you are free to use and redistribute the code but are not allowed to use any part of it under a closed license.

Project Alice belongs to the [Project Alice Organisation](https://docs.projectalice.io/)

## Disclaimer.
This is work in progress. Use it at your own risk.

