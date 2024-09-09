# The worker node

- Kubernetes runs your workloads by placing containers into Pods to run on **nodes**.
- A node may be a virtual or a physical machine.

## Node components

- **kubelet**: The kubelet is a *systemd* service that runs on each node in the cluster, and ensures that the containers are running and healthy, according to a set of PodSpecs (a JSON or YAML file that describes a Pod) that are provided to kubelet. The worker nodes, by way of the kubelet, get instructions from the conteol plane.
- **kube-proxy**: a network proxy that maintains network rules on nodes, allowing network communication to your Pods from network sessions inside or outside of your cluster.
- **container runtime**: the software responsible for running containers.
