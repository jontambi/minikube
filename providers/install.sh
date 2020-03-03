# Instalacion Ansible Engine

sudo yum -y install epel-release && \
sudo yum -y install -y net-tools && \
sudo yum -y update

# Remove OLD Docker CE
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
# Install required packages
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

# Setup repository
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker CE
sudo yum -y install docker-ce docker-ce-cli containerd.io

# Update system
sudo yum -y update

# Start Docker CE
sudo systemctl start docker

# Download minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube

# Add minikube to $PATH
sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/

# Check minikube installtion
minikube start --vm-driver=none

minikube status

#Run commands with ROOT