# Follows guidance from http://www.projectatomic.io/docs/docker-image-author-guidance/

# Deal with PID 1 issue:
FROM phusion/baseimage:latest

MAINTAINER Ron Kurr <kurr@kurron.org>

# Create non-root user
RUN groupadd --system microservice --gid 444 && \
useradd --uid 444 --system --gid microservice --home-dir /home/microservice --create-home --shell /sbin/nologin --comment "Docker image user" microservice && \
chown -R microservice:microservice /home/microservice

# default to being in the user's home directory
WORKDIR /home/microservice

#
# UTF-8 by default
#
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

#
# Pull Zulu OpenJDK binaries from official repository:
#
ENV DEBIAN_FRONTEND noninteractive

# Set standard Java environment variables
ENV JAVA_HOME /usr/lib/jvm/zulu-8-amd64
ENV JDK_HOME /usr/lib/jvm/zulu-8-amd64

# used to set common JVM tunings in the launch script
ENV JVM_HEAP_MIN 128m
ENV JVM_HEAP_MAX 512m
ENV JVM_METASPACE 512m
ENV JVM_CMS_OCCUPANCY 70
ENV JVM_GC_LOG_PATH /var/logs
ENV JVM_GC_LOG_FILE_COUNT 10
ENV JVM_GC_LOG_FILE_SIZE 100M
ENV JVM_DNS_TTL 30
ENV JVM_JMX_HOST 127.0.0.1
ENV JVM_JMX_PORT 9898
ENV JVM_JMX_RMI_PORT 9999

# default to showing the JDK version
CMD ['java', '-version']

# this stuff changes and will create brand new layers
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9
RUN echo "deb http://repos.azulsystems.com/ubuntu stable main" >> /etc/apt/sources.list.d/zulu.list
RUN apt-get -qq update && \
    apt-get -qqy install zulu-8=8.20.0.5 && \
    apt-get clean

# many uses of this container run Docker so let's install the binaries
RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-1.13.1.tgz && tar --strip-components=1 -xvzf docker-1.13.1.tgz -C /usr/local/bin
RUN curl -L "https://github.com/docker/compose/releases/download/1.11.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod 0555 /usr/local/bin/docker-compose

# Switch to the non-root user
USER microservice

# Copy the default JVM launch script for those who don't want to write their own
ADD launch-jvm.sh /home/microservice/launch-jvm.sh
