# Provision the underlying infrastructure to deploy a Kubernetes cluster

## Provisioning the infrastructure using Azure

I'm using Azure, and the Azure CLI, to build the underlying infrastructure for the Kubernetes cluster.

This is the file with all the commands I used to deploy the infrastructure: [infrastructure](/Architecture_Installation_and_Configuration/other_files/Infrastructure.sh)

This Kubernetes cluster is comprised of one control plane and two worker nodes.

## Provisioning the infrastructure using K3D

`k3d cluster create --config k3d-config.yaml`
