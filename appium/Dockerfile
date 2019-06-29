# Use an existing docker image as base
FROM thenishant/android

LABEL maintainer = "Nishant Sharma <theNishant3@gmail.com>"

# install and configure VNC server
ENV USER root
ENV DISPLAY :1
EXPOSE 5901
ADD vncpass.sh /tmp/
ADD watchdog.sh /usr/local/bin/
ADD supervisord_vncserver.conf /etc/supervisor/conf.d/
RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends xfce4 xfce4-goodies xfonts-base dbus-x11 tightvncserver expect && \
    chmod +x /tmp/vncpass.sh; sync && \
    /tmp/vncpass.sh && \
    rm /tmp/vncpass.sh && \
    apt-get remove -y expect && apt-get autoremove -y && \
    FILE_SSH_ENV="/root/.ssh/environment" && \
    echo "DISPLAY=:1" >> $FILE_SSH_ENV

RUN apt-get -qqy update && \
    apt-get -qqy --no-install-recommends install \
    xvfb \
    curl \
  && rm -rf /var/lib/apt/lists/*

ARG NODE_VERSION=v8.11.3
ENV NODE_VERSION=$NODE_VERSION
ARG APPIUM_VERSION=1.13.0
ENV APPIUM_VERSION=$APPIUM_VERSION

# Install appium, node, nodejs
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash && \
    apt-get -qqy install nodejs && \
    npm install -g appium@${APPIUM_VERSION} --unsafe-perm=true --allow-root && \
    exit 0 && \
    npm cache clean && \
    apt-get remove --purge -y npm && \
    apt-get autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get clean

# Expose Portsdockdf
EXPOSE 4723