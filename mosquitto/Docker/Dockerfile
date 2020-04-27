
FROM debian:buster-slim

ARG UID=1000
ARG GID=1000


ENV GROUPID=$GID
ENV USERID=$UID

ENV TERM=screen-256color


ENV USER=pi
ENV HOME=/home/$USER

RUN set -xe \
    #&& sed -i "s/ main/ main non-free/g" /etc/apt/sources.list \
    #&& sed -i "s/deb.debian.org/ftp.dk.debian.org/g" /etc/apt/sources.list \
    && apt-get update && apt-get dist-upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y  sudo mosquitto ca-certificates \
      mc joe less \
    && groupadd --gid ${GROUPID} ${USER} \
    && useradd --uid ${USERID} --gid ${GROUPID} --create-home --shell /bin/bash $USER \
    && echo 'export PATH="$PATH:$HOME/bin"' >> $HOME/.bashrc \
    && echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && apt-get clean \
    && apt-get -y auto-remove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



CMD ["/usr/sbin/mosquitto", "-v", "-c", "/etc/mosquitto/mosquitto.conf"]
