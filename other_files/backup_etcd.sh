# Run these commands in the Control Plane

# Install ettcdctl
sudo apt update
sudo apt install -y etcd-client

# Set the etcd API to version 3
export ETCDCTL_API=3

# Perform a snapshot backup of the current state of etcd
sudo ETCDCTL_API=3 etcdutl snapshot save etcd-backup \
    --cacert /etc/kubernetes/pki/etcd/ca.crt \
    --cert /etc/kubernetes/pki/etcd/server.crt \
    --key /etc/kubernetes/pki/etcd/server.key

# Check the status of the backup file
ETCDCTL_API=3 etcdctl snapshot status etcd-backup --write-out=table

# To restore etcd from the backup, we can first simulate a crash by deleting the kube-proxy DaemonSet
kubectl delete ds kube-proxy -n kube-system

# Perform the restore from the backup file
ETCDCTL_API=3 etcdctl snapshot restore etcd-backup --data-dir /var/lib/etcd-restore

# Edit the etcd.yaml located in the /etc/kubernetes/manifests directory
# Under volumes, and hostPath, replace the path with the one defined in the command above


