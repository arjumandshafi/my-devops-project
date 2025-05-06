#!/bin/bash

# Define log file
LOGFILE="/opt/logs/script_logs.log"

# Create log directory if it doesn't exist
mkdir -p /opt/logs

# Function to echo with date and log
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOGFILE"
}

log "Starting Java installation script..."

# Update system packages
log "Updating package lists..."
sudo apt update -y >> "$LOGFILE" 2>&1

# Install OpenJDK 1.8
log "Installing OpenJDK 1.8..."
sudo apt install -y openjdk-8-jdk >> "$LOGFILE" 2>&1

# Verify installation
JAVA_PATH=$(update-alternatives --list java | grep "java-8" || which java)
log "Java installed at: $JAVA_PATH"

# Get JAVA_HOME (from update-alternatives path)
JAVA_HOME=$(dirname $(dirname $JAVA_PATH))
log "JAVA_HOME is set to: $JAVA_HOME"

# Add JAVA_HOME and update PATH in .bashrc
log "Adding JAVA_HOME and updating PATH in ~/.bashrc..."
echo -e "\n# Java 1.8 environment setup" >> ~/.bashrc
echo "export JAVA_HOME=$JAVA_HOME" >> ~/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc

# Also export in current session
export JAVA_HOME=$JAVA_HOME
export PATH=$JAVA_HOME/bin:$PATH

log "Java installation and environment setup complete."

# End of script
