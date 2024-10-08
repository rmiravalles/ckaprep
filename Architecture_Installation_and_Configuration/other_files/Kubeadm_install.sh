# Run these commands in all Nodes (Control Plane and Worker Nodes)

# Make sure swap is disabled
sudo swapoff -a # This command should give no output

# Set the hosts file
sudo vim /etc/hosts

# Add these lines to the hosts file
10.10.0.4 cp1
10.10.0.5 worker1
10.10.0.6 worker2

# containerd prerequisites
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# Required sysctl parameters to manually enable IPv4 packet forwarding
# These parameters will persist across reboots
cat << EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables = 2
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1
EOF

# To apply the sysctl parameters without rebooting
sudo sysctl --system

# Install containerd
sudo apt install -y containerd

# Create a containerd configuration file
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml

# Set the cgroup driver for containerd
sudo sed -i 's/    SystemdCgroup = false/    SystemdCgroup = true/' /etc/containerd/config.toml

# Verify the changes
grep 'SystemdCgroup = true/' /etc/containerd/config.toml

# Restart containerd
sudo systemctl restart containerd

#Install kubeadm, kubelet and kubectl
#Install the packages needed to use the Kubernetes apt repository and add k8s.io's apt package index
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

#Add the Kubernetes apt repository
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

#Update the package list and use apt-cache policy to inspect versions available in the repository
sudo apt update
apt-cache policy kubelet | head -n 20

#Install the required packages, with an older version. 
#Use this version because later we will upgrade the cluster to a newer version.
VERSION=1.29.7-1.1
sudo apt install -y kubelet=$VERSION kubeadm=$VERSION kubectl=$VERSION

#This is to hold the chosen versions in place, to exclude any system upgrades
sudo apt-mark hold kubelet kubeadm kubectl containerd

#Check the status of the kubelet and containerd.
#The kubelet will be in inactive (dead) state until a cluster is created or the node is joined to an existing cluster.
sudo systemctl status kubelet.service
sudo systemctl status containerd.service

