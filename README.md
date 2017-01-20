# Overview
This project is a simple Docker image that provides the [Azul Systems JDK](http://www.azul.com/downloads/zulu/).
It is based on the [Phusion Base Image](https://hub.docker.com/r/phusion/baseimage/) which, among other things,
handles the PID 1 issue.

# Prerequisites
* a working [Docker](http://docker.io) engine
* a working [Docker Compose](http://docker.io) installation

# Building
Type `docker-compose build` to build the image.

# Installation
Docker will automatically install the newly built image into the cache.

# Tips and Tricks

## Launching The Image

`docker-compose up` will launch the image, show the JVM's version number and exit.  

# Troubleshooting

# License and Credits
This project is licensed under the [Apache License Version 2.0, January 2004](http://www.apache.org/licenses/).

# List of Changes
