#!/usr/bin/env bash
# Installs minikube and some other handy things on the system

# Requirements:
#   - Brew
#   - Functioning Mac OS X installation

# Install minikube, and the hyperkit plugin
echo "Installing Minikube..." \
&& brew cask install minikube \
&& echo "Installing the docker-machine-driver-hyperkit plugin binary for minikube" \
&& curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-hyperkit \
&& chmod +x docker-machine-driver-hyperkit \
&& sudo mv docker-machine-driver-hyperkit /usr/local/bin/ \
&& sudo chown root:wheel /usr/local/bin/docker-machine-driver-hyperkit \
&& sudo chmod u+s /usr/local/bin/docker-machine-driver-hyperkit
