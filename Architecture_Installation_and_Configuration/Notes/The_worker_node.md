# The worker node

- Kubernetes runs your workload by placing containers into Pods to run on **nodes**.
- A node may be a virtual or physical machine.

## Node components

- **kubelet**: runs on each node in the cluster, and ensures that the containers are running and healthy, according to a set of PodSpecs (a JSON or YAML file that describes a Pod) that are provided to kubelet.
- **kube-proxy**: a network proxy that maintains network rules on nodes, allowing network communication to your Pods from network sessions inside or outside of your cluster.
- **container runtime**: the software responsible for running containers.
