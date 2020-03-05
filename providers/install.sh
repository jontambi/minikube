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

# Disable swap
sudo swapoff -a

sudo sed -i "Comentar SWAP LINE in" /etc/fstab

sudo mount -a

# Start Docker CE
sudo systemctl enable docker.service
sudo systemctl start docker

# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl

sudo cp -p kubectl /usr/local/bin/.
sudo cp -p kubectl /usr/bin/.

# CRI-O as CRI runtime.
sudo su -
modprobe overlay
modprobe br_netfilter

# Setup required sysctl params, these persist across reboots.
cat > /etc/sysctl.d/99-kubernetes-cri.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl --system

# Install prerequisites
yum-config-manager --add-repo=https://cbs.centos.org/repos/paas7-crio-115-release/x86_64/os/

# Install CRI-O
yum install --nogpgcheck -y cri-o

# Start CRI-O
systemctl daemon-reload
systemctl start crio

# Download minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube

# Add minikube to $PATH
sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/
sudo cp -p minikube /usr/bin/.
sudo systemctl enable kubelet.service

# Check minikube installtion

sudo minikube start --vm-driver=none

sudo minikube status

