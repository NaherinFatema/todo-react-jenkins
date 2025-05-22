#!/bin/bash

# Update package list
sudo apt update

# Install fontconfig and Java 17
sudo apt install fontconfig openjdk-17-jre -y

# Confirm installation
java -version
