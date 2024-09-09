# Run these commands in all Worker nodes

# Set the desired version as a variable
VERSION=1.29.8-1.1

# Upgrade kubeadm 
sudo apt-mark unhold kubeadm
sudo apt update
sudo apt install -y kubeadm=$VERSION
sudo apt-mark hold kubeadm

# Update the node
sudo kubeadm upgrade node

# Drain any workloads running in the Worker node
# This action is executed in the Control Plane
kubectl drain worker1 --ignore-daemonsets

# Update the kubelet and kubectl
sudo apt-mark unhold kubelet kubectl
sudo apt update
sudo apt install -y kubelet=$VERSION kubectl=$VERSION
sudo apt-mark hold kubelet kubectl

# Reload and restart the systemd services
sudo systemctl daemon-reload
sudo systemctl restart kubelet
sudo systemctl status kubelet

# If you drained the Worker node in the previous step, uncordon it
# Again, this is done from the Control Plane
kubectl uncordon worker1



