# ###########################################################################################
# Basic docker build of SDL_Core https://github.com/smartdevicelink/sdl_core
#
# NOTE: The container run the container using host networking by using the --net="host" flag.
#
# ###########################################################################################

# This image is based of debian with curl preinstalled
FROM buildpack-deps:jessie-curl

MAINTAINER Corey Maylone version:0.1

# Create our working directory    
RUN mkdir /usr/sdl/

# Change directory to our newly created working directory
WORKDIR /usr/sdl
    
# Download and unpack SDL Core from github. The 
RUN curl -sSL https://github.com/smartdevicelink/sdl_core/archive/develop.tar.gz \ 
        | tar -v -C ./ -xz

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \ 
        cmake \
        libavahi-client-dev \
        libavahi-common-dev \
        libbluetooth-dev \
        liblog4cxx* \
        libudev-dev \
        libsqlite3-dev \
        libssl-dev \
        python \
        sudo \
        sqlite3     

# Change directory to the unpacked SDL Core sourcecode
WORKDIR sdl_core-develop

# Generate our Makefile
RUN cmake $(pwd)

# Compile and install
RUN make && make install

# Copy required key and certification
RUN cp bin/mykey.pem src/appMain && cp bin/mycert.pem src/appMain

# Change directory to the main folder for SDL Core
WORKDIR src/appMain/

# Copy SDL Core start script into container
COPY ../start.sh start.sh

# Configure logger
RUN ldconfig

# Expose SDL Core's primary port. Used to communicate with the SDL Core instance over wifi
EXPOSE 12345 

# Expose SDL Core's Web Socket port. Used to comunicate with the HMI
EXPOSE 8087

# Run the start script the will launch SDL Core!
CMD ["/bin/bash", "start.sh"]
