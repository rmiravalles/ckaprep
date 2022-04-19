# Kubernetes components

## Introduction

- When you deploy Kubernetes, you get a **cluster**.
- A Kubernetes cluster is made of a **control plane (cp)** and a set of **worker nodes**.
- The worker nodes host the **Pods** that are the components of the application workload.
- A **Pod** is a group of one or more containers, with shared storage and network resources. It's the smallest deployable unit of computing that you can create and manage in Kubernetes.
- **The control plane manages the worker nodes and the Pods in the cluster.**

![Components](../../media/components-of-kubernetes.svg)

## The control plane

- The control plane is the container orchestration layer that exposes the API and interfaces to define, deploy and manage the lifecycle of containers.
- The control plane's components make global decisions about the cluster, as well as detecting and responding to cluster events.

### Control plane components

- **kube-apiserver**: the kube-apiserver exposes the Kubernetes API, it's the front end for the Kubernetes control plane.
- **etcd**: consistent and highly-available key value store used as Kubernetes' backing store for all cluster data.
- **kube-scheduler**: watches for newly created Pods with no assigned node, and selects a node for them to run on, taking into account factors such as resource requirements, constraints, and data locality.
- **kube-controller-manager**: runs control loops that watch the shared state of the cluster through the apiserver and makes changes attempting to move the current state towards the desired state.
- **cloud-controller-manager**: lets you link your cluster into your cloud provider's API, and separates out the components that interact with the cloud platform from components that only interact with your cluster.

## The worker node

- Kubernetes runs your workload by placing containers into Pods to run on **nodes**.
- A node may be a virtual or physical machine.

### Node components

- **kubelet**: runs on each node in the cluster, and ensures that the containers are running and healthy, according to a set of PodSpecs (a JSON or YAML file that describes a Pod) that are provided to kubelet.
- **kube-proxy**: a network proxy that maintains network rules on nodes, allowing network communication to your Pods from network sessions inside or outside of your cluster.
- **container runtime**: the software responsible for running containers.
