# The control plane

- The control plane is the container orchestration layer that exposes the API and interfaces to define, deploy and manage the lifecycle of containers.
- The control plane's components make global decisions about the cluster, as well as detecting and responding to cluster events.

## Control plane components

- **kube-apiserver**: the kube-apiserver exposes the Kubernetes API, it's the front end for the Kubernetes control plane.
- **etcd**: consistent and highly-available key value store used as Kubernetes' backing store for all cluster data.
- **kube-scheduler**: watches for newly created Pods with no assigned node, and selects a node for them to run on, taking into account factors such as resource requirements, constraints, and data locality.
- **kube-controller-manager**: runs control loops that watch the shared state of the cluster through the apiserver and makes changes attempting to move the current state towards the desired state.
- **cloud-controller-manager**: lets you link your cluster into your cloud provider's API, and separates out the components that interact with the cloud platform from components that only interact with your cluster.
