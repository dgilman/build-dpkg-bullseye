FROM debian:bullseye
LABEL maintainer="David Gilman <davidgilman1@gmail.com>"

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Installs the `dpkg-buildpackage` command
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install build-essential debhelper devscripts git-buildpackage

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
