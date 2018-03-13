# base-image for node on any machine using a template variable,
# see more about dockerfile templates here: http://docs.resin.io/deployment/docker-templates/
# and about resin base images here: http://docs.resin.io/runtime/resin-base-images/
# Note the node:slim image doesn't have node-gyp
FROM resin/raspberrypi-node:latest

# Get node source info
#RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

# use apt-get if you need to install dependencies,
# for instance if you need ALSA sound utils, just uncomment the lines below.
RUN apt-get update && apt-get install -yq \
    git make python g++ nodejs avahi-daemon avahi-discover libnss-mdns \
    libavahi-compat-libdnssd-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN /etc/init.d/dbus start
RUN /etc/init.d/avahi-daemon start

# Install homebridge
RUN npm install -g --unsafe-perm homebridge
RUN npm install -g --unsafe-perm homebridge-platform-wemo

# Copy config over
WORKDIR /root/.homebridge/

# Copy
COPY start.sh start.sh
COPY config.json config.json

# Execute permissions
RUN chmod +x start.sh

# Enable systemd init system in container
ENV INITSYSTEM on

# Expose port
EXPOSE 5353 51826

# Exec homebridge with persistent config
CMD /bin/bash /root/.homebridge/start.sh
