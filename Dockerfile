FROM openjdk:11-jdk

# Install dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    libgtk-3-0 \
    libwebkit2gtk-4.0-37 \
    && rm -rf /var/lib/apt/lists/*

# Define variables
ENV PDI_VERSION=10.2.0.0-222
ENV PDI_ZIP=pdi-ce-${PDI_VERSION}.zip
ENV PDI_URL="https://privatefilesbucket-community-edition.s3.us-west-2.amazonaws.com/${PDI_VERSION}/ce/client-tools/${PDI_ZIP}"
ENV PDI_CACHE=/opt/pdi-cache

# Create cache directory
RUN mkdir -p ${PDI_CACHE}

# Set up entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set environment variables
ENV PENTAHO_HOME=/opt/data-integration
WORKDIR $PENTAHO_HOME

# Expose Pentaho folder as a volume
VOLUME ["/opt/data-integration"]

# Set entrypoint to check for file and run Spoon GUI
ENTRYPOINT ["/entrypoint.sh"]
