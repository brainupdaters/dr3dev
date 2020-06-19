#!/bin/bash

# Install kubectl
KUBECTL_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
#curl -Lo ./kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
echo "## Downloading kubectl $KUBECTL_VERSION ..."
curl -Lo ./kubectl https://storage.googleapis.com/kubernetes-release/release/"$KUBECTL_VERSION"/bin/linux/amd64/kubectl -#
chmod +x ./kubectl

# Install kind
KIND_VERSION=$(curl --silent "https://api.github.com/repos/kubernetes-sigs/kind/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
echo "## Downloading kind $KIND_VERSION ..."
#curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/download/$(curl --silent "https://api.github.com/repos/kubernetes-sigs/kind/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')/kind-$(uname)-amd64
curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/download/"$KIND_VERSION"/kind-$(uname)-amd64 -#
chmod +x ./kind

