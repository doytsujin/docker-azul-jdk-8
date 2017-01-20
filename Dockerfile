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

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9
RUN echo "deb http://repos.azulsystems.com/ubuntu stable main" >> /etc/apt/sources.list.d/zulu.list
RUN apt-get -qq update && \
    apt-get -qqy install zulu-8=8.19.0.1 && \
    apt-get clean

# Switch to the non-root user
USER microservice

# default to showing the JDK version
CMD ['java', '-version']
