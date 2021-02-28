#  time docker build $BUILD_ARGS --force-rm --build-arg UID=$"$USERID" --build-arg GID=$"$GROUPID"  -t poulsp/alice-amd -f Docker/Dockerfile .

FROM python:3.7.7-buster

ARG UID=1000
ARG GID=1000

ENV GROUPID=$GID
ENV USERID=$UID

ENV TERM=screen-256color

ENV USER=pi
ENV HOME=/home/$USER

ENV RELEASE="0.21.0"
ENV URL="https://github.com/badaix/snapcast/releases/download/v${RELEASE}/snapserver_${RELEASE}-1_amd64.deb"
ENV snapServerDeb="snapserver_${RELEASE}-1_amd64.deb"


COPY ./Docker/systemctl /bin/systemctl

# wget https://debian.snips.ai/stretch/pool/s/sn/snips-platform-common_0.64.0_amd64.deb \
# && wget https://debian.snips.ai/stretch/pool/s/sn/snips-nlu_0.64.0_amd64.deb \
# && wget https://debian.snips.ai/jessie/pool/s/sn/snips-asr-model-en-500MB_0.6.0-alpha.4_amd64.deb \
# && wget https://debian.snips.ai/stretch/pool/s/sn/snips-kaldi-atlas_0.26.1_amd64.deb \
# && wget https://debian.snips.ai/stretch/pool/s/sn/snips-hotword-model-heysnipsv4_0.64.0_amd64.deb \
# && wget https://debian.snips.ai/stretch/pool/s/sn/snips-hotword_0.64.0_amd64.deb \
# && wget https://debian.snips.ai/stretch/pool/s/sn/snips-asr_0.64.0_amd64.deb \
# && wget https://debian.snips.ai/stretch/pool/s/sn/snips-platform-voice_0.64.0_amd64.deb \
# && wget https://debian.snips.ai/stretch/pool/s/sn/snips-watch_0.64.0_amd64.deb

# COPY ./Docker/snips-platform-common_0.64.0_amd64.deb /
# COPY ./Docker/snips-platform-voice_0.64.0_amd64.deb /
# COPY ./Docker/snips-watch_0.64.0_amd64.deb /
# COPY ./Docker/snips-hotword-model-heysnipsv4_0.64.0_amd64.deb /
# COPY ./Docker/snips-hotword_0.64.0_amd64.deb /
# COPY ./Docker/snips-nlu_0.64.0_amd64.deb /
# COPY ./Docker/snips-asr-model-en-500MB_0.6.0-alpha.4_amd64.deb /
# COPY ./Docker/snips-kaldi-atlas_0.26.1_amd64.deb /
# COPY ./Docker/snips-asr_0.64.0_amd64.deb /


RUN set -xe \
    && cd / \
    && chmod 0755 /bin/systemctl \
    && sed -i "s/ main/ main non-free/g" /etc/apt/sources.list \
    && apt-get update && apt-get dist-upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y  sudo gnupg2 dirmngr apt-transport-https apt-utils \
    && groupadd --gid ${GROUPID} ${USER} \
    && useradd --uid ${USERID} --gid ${GROUPID} --create-home --shell /bin/bash $USER \
    && echo 'export PATH="$PATH:$HOME/bin"' >> $HOME/.bashrc \
    && echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && chown -R $USER:$USER $HOME \
    && apt update \
    && apt dist-upgrade \
    && DEBIAN_FRONTEND=noninteractive apt install -y  \
        tzdata \
        apt-transport-https \
        apt-utils \
        mc joe less \
        curl \
        wget \
        unzip \
        git \
        psmisc \
        procps \
        python-dev \
        libpython3.7-dev \
        supervisor \
        alsa-utils \
        libttspico0 \
        libttspico-utils \
        libatlas3-base=3.10.3-8 \
        zip \
        unzip \
        mpg123 \
        dirmngr \
        gcc \
        make \
        pkg-config \
        automake \
        libtool \
        libicu-dev \
        libpcre2-dev \
        libasound2-dev \
        portaudio19-dev \
        python-pyaudio \
        python3-pyaudio \
        libffi-dev \
        python3-wheel \
        mosquitto \
        mosquitto-clients \
        libxml2-dev \
        libxslt-dev \
        flac \
        libatlas-base-dev \
        gfortran  \
        ffmpeg \
        nginx \
    && usermod -a -G audio ${USER} \
    && cd / \
    &&  wget https://debian.snips.ai/stretch/pool/s/sn/snips-platform-common_0.64.0_amd64.deb \
    && wget https://debian.snips.ai/stretch/pool/s/sn/snips-nlu_0.64.0_amd64.deb \
    && wget https://debian.snips.ai/jessie/pool/s/sn/snips-asr-model-en-500MB_0.6.0-alpha.4_amd64.deb \
    && wget https://debian.snips.ai/stretch/pool/s/sn/snips-kaldi-atlas_0.26.1_amd64.deb \
    && wget https://debian.snips.ai/stretch/pool/s/sn/snips-hotword-model-heysnipsv4_0.64.0_amd64.deb \
    && wget https://debian.snips.ai/stretch/pool/s/sn/snips-hotword_0.64.0_amd64.deb \
    && wget https://debian.snips.ai/stretch/pool/s/sn/snips-asr_0.64.0_amd64.deb \
    && wget https://debian.snips.ai/stretch/pool/s/sn/snips-platform-voice_0.64.0_amd64.deb \
    && wget https://debian.snips.ai/stretch/pool/s/sn/snips-watch_0.64.0_amd64.deb \
    && DEBIAN_FRONTEND=noninteractive apt install -y --allow-unauthenticated \
        ./snips-platform-common_0.64.0_amd64.deb \
        ./snips-platform-voice_0.64.0_amd64.deb \
        ./snips-watch_0.64.0_amd64.deb \
        ./snips-hotword-model-heysnipsv4_0.64.0_amd64.deb \
        ./snips-hotword_0.64.0_amd64.deb \
        ./snips-nlu_0.64.0_amd64.deb \
        ./snips-asr-model-en-500MB_0.6.0-alpha.4_amd64.deb \
        ./snips-kaldi-atlas_0.26.1_amd64.deb \
        ./snips-asr_0.64.0_amd64.deb \
    && chown -R $USER:$USER /usr/share/snips \
    && chown -R $USER:$USER /var/lib/snips \
    && rm /snips-platform-common_0.64.0_amd64.deb \
    && rm /snips-nlu_0.64.0_amd64.deb \
    && rm /snips-asr-model-en-500MB_0.6.0-alpha.4_amd64.deb \
    && rm /snips-kaldi-atlas_0.26.1_amd64.deb \
    && rm /snips-hotword-model-heysnipsv4_0.64.0_amd64.deb \
    && rm /snips-hotword_0.64.0_amd64.deb \
    && rm /snips-asr_0.64.0_amd64.deb \
    && rm /snips-platform-voice_0.64.0_amd64.deb \
    && rm /snips-watch_0.64.0_amd64.deb \
    && DEBIAN_FRONTEND=noninteractive apt install -y  \
        avahi-daemon bind9-host geoip-database libavahi-client3 libavahi-common-data libavahi-common3 \
        libavahi-core7 libbind9-161 libdaemon0 libdns1104 libfstrm0 libgeoip1 libisc1100 libisccc161 libisccfg163 \
        liblmdb0 liblwres161 libnss-mdns libprotobuf-c1 \
    && cd / \
    && wget ${URL} \
    && dpkg -i ${snapServerDeb} \
    && apt-get -f install -y \
    && rm ${snapServerDeb} \
    && systemctl stop snapserver  \
    && sed -i "s/\.*source = pipe:\/\/\/tmp\/snapfifo?name=default/source = pipe:\/\/\/dev\/shm\/snapfifo?name=default/" /etc/snapserver.conf \
    && sed -i "s/\.*stream = pipe:\/\/\/tmp\/snapfifo?name=default/stream = pipe:\/\/\/dev\/shm\/snapfifo?name=default/" /etc/snapserver.conf \
    && sed -i "s/\.*User=snapserver/User=pi/" /lib/systemd/system/snapserver.service \
    && sed -i "s/\.*Group=snapserver/Group=pi/" /lib/systemd/system/snapserver.service \
    && apt-get clean \
    && apt-get -y auto-remove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN set -xe \
    && apt-get update


USER $USER
WORKDIR $HOME


#ENTRYPOINT ["/tini", "--"]
#CMD ["/bin/bash","/start-scripts/start-snips.sh"]
CMD ["tail", "-f", "/dev/null"]
