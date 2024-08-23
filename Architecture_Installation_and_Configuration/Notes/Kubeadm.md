# Use Kubeadm to install a basic cluster

## Overview

- Kubeadm is a tool to bootstrap a Kubernetes cluster

## Resources

[Installing Kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

## The process

I'll install all the necessary components (**kubeadm**, **kubelet**, **kubectl**, and **containerd**) in the 3 Azure VMs I created earlier.

[Preparing the nodes](/other_files/Kubeadm_install.sh)

## Notes

- Kubeadm does not install or manage kubelet or kubectl, so we need to ensure they match the version of the Kubernetes control plane you want kubeadm to install. If we don't do this, there is a risk of a version skew occurring that can lead to unexpected, buggy behaviour.
