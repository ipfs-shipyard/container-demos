FROM registry

# Add the custom configuration file we made
ADD ./config.yml /docker-registry/config/config.yml

# Create the data directory
# This is intended to be bind-mounted to IPFS via FUSE on the
# host machine
RUN mkdir -p /ipns/local/docker-registry/

# Set the configuration file to config.yml
env DOCKER_REGISTRY_CONFIG /docker-registry/config/config.yml

# Make sure we use the prod configuration settings
env SETTINGS_FLAVOR prod
