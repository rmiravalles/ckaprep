# Run these commands in the Control Plane node

# To check the current version of the tools we have installed
kubectl get nodes
kubectl version
kubeadm version

# Update the system
sudo apt update

# Find the version we want to upgrade to
# The output of the command below will show the installed version and the best candidate for the upgrade
# We can only upgrade a minor version to the next minor version
apt-cache policy kubeadm

# Set the desired version as a variable
VERSION=1.29.8-1.1

# Unlock kubeadm to allow the upgrade
sudo apt-mark unhold kubeadm
sudo apt update

# Install the new version of kubeadm
sudo apt install -y kubeadm=$VERSION

# Hold the newly upgraded version in place
sudo apt-mark hold kubeadm

# Check the new version
kubeadm version

# Run the upgrade plan
# This will test the upgrade process and run pre-flight checks
# The version here is written differently than the package's version
sudo kubeadm upgrade plan v1.29.8

# Upgrade the cluster
sudo kubeadm upgrade apply v1.29.8

# Drain the worloads on the Control Plane Node
kubectl drain cp1 --ignore-daemonsets

# Update the kubelet and kubectl
sudo apt-mark unhold kubelet kubectl
sudo apt update
sudo apt install -y kubelet=$VERSION kubectl=$VERSION
sudo apt-mark hold kubelet kubectl

# Reload and restart the processes in systemd
sudo systemctl daemon-reload
sudo systemctl restart kubelet
sudo systemctl status kubelet

# Check the current version
kubectl version
kubectl get nodes