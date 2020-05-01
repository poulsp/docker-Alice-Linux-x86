FROM python:3.7.7-buster

ARG UID=1000
ARG GID=1000

ENV GROUPID=$GID
ENV USERID=$UID

ENV TERM=screen-256color

ENV USER=pi
ENV HOME=/home/$USER

RUN set -xe \
    && cd / \
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
#RUN set -xe \
    && echo "deb https://debian.snips.ai/stretch stable main" > /etc/apt/sources.list.d/snips.list \
    && apt-key adv --fetch-keys https://debian.snips.ai/5FFCD0DEB5BA45CD.pub \
    && wget -q https://ftp-master.debian.org/keys/release-10.asc -O- | apt-key add - \
    && apt-key adv --fetch-keys https://raspbian.snips.ai/531DD1A7B702B14D.pub \
    && apt update \
#RUN set -xe \
    && DEBIAN_FRONTEND=noninteractive apt install -y  \
        libttspico0 \
        libttspico-utils \
        libatlas3-base=3.10.3-8 \
#RUN set -xe \
    # sysrequirements.txt
    && DEBIAN_FRONTEND=noninteractive apt install -y --allow-unauthenticated \
        #apt-transport-https \
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
        mosquitto \
        mosquitto-clients \
        libxml2-dev \
        libxslt-dev \
        flac \
        libatlas-base-dev \
        gfortran  \
        ffmpeg \
#RUN set -xe \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    snips-platform-voice \
    snips-makers-tts \
    snips-watch \
    snips-hotword-model-heysnipsv4\
    && chown -R $USER:$USER /usr/share/snips \
    && chown -R $USER:$USER /var/lib/snips \
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
