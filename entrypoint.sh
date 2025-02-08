#!/bin/bash

PDI_CACHE="/opt/pdi-cache"
PDI_ZIP="${PDI_CACHE}/pdi-ce-10.2.0.0-222.zip"
PDI_FOLDER="/opt/data-integration"
PDI_URL="https://privatefilesbucket-community-edition.s3.us-west-2.amazonaws.com/9.4.0.0-343/ce/client-tools/pdi-ce-9.4.0.0-343.zip"

# Check if the ZIP exists; if not, download it
if [ ! -f "${PDI_ZIP}" ]; then
    echo "File not found. Downloading..."
    wget -O "${PDI_ZIP}" "${PDI_URL}"
else
    echo "File already exists. Skipping download."
fi

# Ensure PDI is extracted
if [ ! -d "${PDI_FOLDER}" ] || [ ! -f "${PDI_FOLDER}/spoon.sh" ]; then
    echo "Extracting PDI..."
    unzip -o "${PDI_ZIP}" -d /opt
    # rm "${PDI_ZIP}"
else
    echo "PDI already extracted. Skipping extraction."
fi

# Ensure spoon.sh is executable
chmod +x "${PDI_FOLDER}/spoon.sh"

# Start Spoon GUI
exec "${PDI_FOLDER}/spoon.sh"
