# The control plane

- The control plane is the container orchestration layer that exposes the API and interfaces to define, deploy and manage the lifecycle of containers.
- The control plane's components make global decisions about the cluster, as well as detecting and responding to cluster events.

## Control plane components

The Control Plane components all run as Pods in the `kube-system` namespace. We refer to them as system Pods.

To view these Pods, we can run the following command:

`kubectl get pods -n kube-system`

![Pods in the kube-system namespace](/media/kubesystem.png)

- **kube-apiserver**: the kube-apiserver exposes the Kubernetes API, it's the front end for the Kubernetes control plane, so all communication to the cluster passess through it.
- **etcd**: consistent and highly-available key value store used as Kubernetes' backing store for all cluster data (the *state* of Kubernetes).
- **kube-scheduler**: watches for newly created Pods with no assigned node, and selects a node for them to run on, taking into account factors such as resource requirements, constraints, and data locality.
- **kube-controller-manager**: runs control loops that watch the shared state of the cluster through the apiserver and makes changes attempting to move the current state towards the desired state.
- **cloud-controller-manager**: lets you link your cluster into your cloud provider's API, and separates out the components that interact with the cloud platform from components that only interact with your cluster.

**coreDNS** is also a Pod that runs on the Control Plane, but it's considered a plugin, not a core system. The CNI Pods, Calico in this case, are also considered plugins.

**kube-proxy** is an agent that runs on every node of the cluster. It monitors the changes that happen to Service objects and their endpoints, and translates them into network rules inside the node. **kube-proxy** helps with the Service to Pod mapping by maintaining a network routing table that maps Service IP addresses to the IP addresses of the Pods that belong to the Service. It usually runs as a **DaemonSet**. Kubeadm will install kube-proxy as DaemonSet.

By default, application Pods will not run on the control plane node. The control plane has a special attribute assigned to it called a **taint**. A taint will disable scheduling to that node unless a certain specification exists in the YAML spec called a toleration.
