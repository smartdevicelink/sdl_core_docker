# ###########################################################################################
# Basic docker build of SDL_Core https://github.com/smartdevicelink/sdl_core
#
# NOTE: The container run the container using host networking by using the --net="host" flag.
#
# ###########################################################################################

# This image is based of debian with curl preinstalled
FROM buildpack-deps:jessie-curl

MAINTAINER Corey Maylone version:0.1

ENV SDL_CORE_BRANCH develop
ENV SDL_CORE_NETWORK_INTERFACE eth0
ENV HMI_WEBSOCKET_ADDRESS 127.0.0.1:8087

# Create our working directory and Download SDL Core from github   
RUN mkdir /usr/sdl/ \
    && curl -sSL https://github.com/smartdevicelink/sdl_core/archive/$SDL_CORE_BRANCH.tar.gz \
    | tar -v -C /usr/sdl -xz --strip-components 1
    
# Download SDL HMI from github
RUN mkdir /var/www \
    && curl -sSL https://github.com/smartdevicelink/sdl_hmi/archive/master.tar.gz \
    | tar -v -C /var/www -xz --strip-components 1

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \ 
        cmake \
        libavahi-client-dev \
        libavahi-common-dev \
        libbluetooth-dev \
        libudev-dev \
        libsqlite3-dev \
        libssl-dev \
        nginx \
        python \
        sudo \
        supervisor \
        sqlite3     

# Change directory to the unpacked SDL Core sourcecode
WORKDIR /usr/sdl/

# Generate our Makefile, compile it and install
RUN cmake . \
    && make \
    && make install
    
# Copy required key and certification
RUN cp bin/mykey.pem src/appMain \ 
    && cp bin/mycert.pem src/appMain

# Change directory to the main folder for SDL Core
WORKDIR src/appMain/

# Copy SDL Core start script into container
COPY setup.sh setup.sh

# Configure logger
RUN ldconfig

# Delete default nginx configuration
RUN rm -v /etc/nginx/nginx.conf

# Copy our new configuration
COPY nginx.conf /etc/nginx/

# Copy supervisord config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose the following ports
#   8087:  Expose SDL Core's Web Socket port. Used to comunicate with the HMI
#   8080:  Returns index.html of HMI Core
#   12345: Expose SDL Core's primary port. Used to communicate with the SDL Core instance over wifi
EXPOSE 8087 8080 12345 

# Run the start script that will launch SDL Core!
CMD ["/bin/bash", "setup.sh"]
