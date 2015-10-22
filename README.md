# NarraFirma Docker File

A Dockerfile to run [NarraFirma](http://narrafirma.com) as a stand-alone Node.js app. It can also be run as a Wordpress plugin. See the NarraFirma [install directions](https://narrafirma.com/home/setting-up-narrafirma-on-your-local-computer/) for more details.

## To build the image (don't miss the dot at the end)
    docker build -t "eliza411/narrafirma" .

## To run the container:
  -p: The first port in each pair is the host port; change as needed. 8081 is
the https port with a self-signed cert.

  -e: Specify your superuser credentials.

    docker run -p 8080:8080 -p 8081:8081 \
    -e NF_SUPERUSER=changethis -e NF_PASSWORD=changethis eliza411/narrafirma

Review the Dockerfile itself for more detail.
