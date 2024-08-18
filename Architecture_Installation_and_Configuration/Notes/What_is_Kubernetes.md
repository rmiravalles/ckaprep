# Introduction

- When you deploy Kubernetes, you get a **cluster**.
- It's a called a *cluster* because it's a **RESTful API** of machines working in conjunction.
- The main difference in Kubernetes is that the interconnected servers not only distribute loads appropriately, but also easily exchange data to eliminate a single point of failure.
- **If one of the nodes fail, it doesn't bring down the entire cluster**.
- Kubernetes is nothing more than a piece of software that you interact with via a REST API.
- A RESTful API is a well-defined, highly scalable, loosely coupled application architecture that favors communication over a network, and, more importantly, the act of transferring the state of a resource over a network.
- We commonly interact with the Kubernetes API, and the objects within, by using a command-line tool called **kubectl**.
- A Kubernetes cluster is made of a **control plane (cp)** and a set of **worker nodes**.
- The worker nodes host the **Pods** that are the components of the application workload.
- A **Pod** is a group of one or more containers, with shared storage and network resources. It's the smallest deployable unit of computing that you can create and manage in Kubernetes.
- **The control plane manages the worker nodes and the Pods in the cluster.**

![Components](../../media/components-of-kubernetes.svg)
