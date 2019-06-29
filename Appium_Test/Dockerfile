# Use an existing docker image as base
FROM ubuntu:18.04

LABEL maintainer = "Nishant Sharma <theNishant3@gmail.com>"

# Download and install a dependency
RUN apt-get -qqy update && \
    apt-get -qqy --no-install-recommends install \
    openjdk-8-jdk \
    unzip \
    curl \
    wget \
    xvfb \
  && rm -rf /var/lib/apt/lists/*

    # Install android sdk
ARG ANDROID_SDK_VERSION=4333796
ENV ANDROID_SDK_VERSION=$ANDROID_SDK_VERSION

RUN mkdir -p /opt/sdk \
    && wget -q https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip \
    && unzip sdk-tools-linux-${ANDROID_SDK_VERSION}.zip -d /opt/sdk \
    && rm sdk-tools-linux-${ANDROID_SDK_VERSION}.zip \
    && wget -q https://dl.google.com/android/repository/platform-tools-latest-linux.zip \
    && unzip platform-tools-latest-linux.zip -d /opt/sdk \
    && rm platform-tools-latest-linux.zip \
    && mkdir -p ${HOME}/.android/ \
    && ln -s /opt/sdk/platform-tools/adb /usr/bin
ENV ANDROID_HOME /opt/sdk

    # Install latest nodejs, npm, appium
ARG NODE_VERSION=v8.11.3
ENV NODE_VERSION=$NODE_VERSION
ARG APPIUM_VERSION=1.13.0
ENV APPIUM_VERSION=$APPIUM_VERSION

    # install appium
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash && \
    apt-get -qqy install nodejs && \
    npm install -g appium@${APPIUM_VERSION} --unsafe-perm=true --allow-root && \
    exit 0 && \
    npm cache clean && \
    apt-get remove --purge -y npm && \
    apt-get autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get clean

# Tell the image what to do when it starts as a container
    #===============
    # Expose Ports
EXPOSE 4723
COPY docker-config.sh /root
RUN chmod +x /root/docker-config.sh
CMD /root/docker-config.sh
CMD tail -f /dev/null