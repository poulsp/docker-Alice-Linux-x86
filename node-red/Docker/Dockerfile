
#docker pull nodered/node-red-docker:rpi-v8

FROM nodered/node-red-docker:rpi-v8



# dette er ikke nødvendig når vi bruger FROM nodered/node-red-docker kun bår vi bruger FROM node:8
# # Add node-red user so we aren't running as root.
# RUN  set -ex \
#     && chown -R 1000:1000 /data \
#     && chown -R 1000:1000 /usr/src/node-red

RUN  set -ex \
  #&& apt-get install -y mc joe \
  && npm install node-red-dashboard

    # npm install node-red-contrib-nora
    # npm  install moment
    # npm  install node-red-contrib-config
    # npm  install node-red-contrib-grove
    # npm  install node-red-contrib-bigtimer
    # npm  install node-red-contrib-esplogin
    # npm  install node-red-contrib-timeout
    # npm  install node-red-node-pushbullet
    # npm  install node-red-node-openweathermap
    # npm  install node-red-node-google
    # npm  install node-red-node-sqlite
    # npm  install node-red-node-emoncms
    # npm  install node-red-node-geofence
    # npm  install node-red-contrib-ivona
    # npm  install
    # npm  install node-red-contrib-particle
    # npm  install node-red-contrib-web-worldmap
    # npm  install node-red-contrib-graphs
    # npm  install node-red-contrib-isonline
    # npm  install node-red-node-ping
    # npm  install node-red-node-random
    # npm  install node-red-node-smooth
    # npm  install node-red-contrib-npm
    # npm  install node-red-contrib-file-function
    # npm  install node-red-contrib-boolean-logic
    # npm  install node-red-node-arduino
    # npm  install node-red-contrib-blynk-websockets
    # npm  install node-red-dashboard
    # npm  install node-red-node-darksky
    # npm install node-red-node-weather-underground
