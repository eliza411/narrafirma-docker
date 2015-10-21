FROM node
MAINTAINER Melissa Anderson <melissa@happypunch.com>

# Set the version of Narrafirma
ENV NF_VERSION 0.9.2

# Temporary superuser name and password. These should be overridden when
# the container is run
ENV NF_SUPERUSER superuser
ENV NF_PASSWORD password

# To build the image in this directory (don't miss the dot at the end):
#   docker build -t "eliza411/narrafirma" .

# To run the container:
#  -p: The first port in each pair is the host port; change as needed.
#      8081 is the https port with a self-signed cert.
#  -e: Specify your superuser credentials.
#  docker run -p 8080:8080 -p 8081:8081 -e NF_SUPERUSER=changethis -e NF_PASSWORD=changethis eliza411/narrafirma

RUN apt-get install curl
RUN npm install -g typescript

# Run as a non-privileged user
RUN groupadd -r narrafirma && useradd -r -m -g narrafirma narrafirma
USER narrafirma
WORKDIR /home/narrafirma

# Get narrafirma
RUN curl -LO https://github.com/pdfernhout/narrafirma/archive/v$NF_VERSION.tar.gz
RUN tar -xzvf v$NF_VERSION.tar.gz

# Compile the javascript. true is set to allow the build to complete despite tsc errors.
WORKDIR /home/narrafirma/narrafirma-$NF_VERSION/webapp/js
RUN tsc; true

# Run the application
WORKDIR /home/narrafirma/narrafirma-$NF_VERSION/server
CMD node admin.js update-superuser $NF_SUPERUSER $NF_PASSWORD && node NarraFirmaServer.js
