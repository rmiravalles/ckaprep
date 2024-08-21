# These commands should be run in the Control Plane node

# Downloaad the yaml file for the pod network add-on
# Here I'm going to use Calico
wget https://raw.githubusercontent.com/projectcalico/calico/master/manifests/calico.yaml

# Use the command kubeadm init to bootstrap the cluster
# Make sure you're using the same version as kubeadm, kubectl, and kubelet
sudo kubeadm init --kubernetes-version v1.29.7

# Configure the accout on the Control Plane to have admin access to the API Server
# from a non-privileged account
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Create the Pod network
kubectl apply -f calico.yaml

# Once the cluster is ready, we can add more nodes to it
#Run the command below in the worker nodes
# This command appears in the output of kubeadm init
sudo kubeadm join cp1:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>

# If you didn't take note of the token, you can run this command
# The token is valid for 24 hours
kubeadm token list

# To create a new token
kubedm token create

# To obtain the value of the discovery-token-ca-cert-hash
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | \
   openssl dgst -sha256 -hex | sed 's/^.* //'