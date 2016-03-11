# Trusty 
FROM ubuntu:14.04

MAINTAINER Ron Kurr <kurr@kurron.org>

ENV DEBIAN_FRONTEND noninteractive

# Install JDK 8 
RUN apt-get --quiet update && \
    apt-get --quiet --yes install wget && \
    apt-get clean && \
    wget --quiet \
         --output-document=/jdk-8.tar.gz \
         http://cdn.azul.com/zulu/bin/zulu8.13.0.5-jdk8.0.72-linux_x64.tar.gz && \
    mkdir -p /usr/lib/jvm && \
    tar --gunzip --extract --verbose --file /jdk-8.tar.gz --directory /usr/lib/jvm && \
    rm -f /jdk-8.tar.gz && \
    chown -R root:root /usr/lib/jvm

# set the environment variables 
ENV JDK_HOME /usr/lib/jvm/zulu8.13.0.5-jdk8.0.72-linux_x64
ENV JAVA_HOME /usr/lib/jvm/zulu8.13.0.5-jdk8.0.72-linux_x64
ENV PATH $PATH:$JAVA_HOME/bin

# Force Docker to use UTF-8 encodings
ENV LANG C.UTF-8

# export meta-data about this container
LABEL org.kurron.java.vendor="Azul"  org.kurron.java.version="1.8.0_72"


