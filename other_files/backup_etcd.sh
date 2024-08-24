# Run these commands in the Control Plane

# Install ettcdctl
sudo apt update
sudo apt install -y etcd-client

# Set the etcd API to version 3
export ETCDCTL_API=3

# Perform a snapshot backup of the current state of etcd
etcdctl snapshot save \
    --cacert /etc/kubernetes/pki/etcd/ca.crt \
    --cert /etc/kubernetes/pki/etcd/server.crt \
    --key /etc/kubernetes/pki/etcd/server.key \
    /tmp/etcd-backup.db