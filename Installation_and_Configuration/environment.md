# Preparing the environment

I'm using Azure to build the environments for the labs. I chose Azure because I'm most comfortable with it, but any platform will do.

For this first lab, I deployed 2 **Ubuntu 20.04** virtual machines. One served as the control plane, and the other as the worker node.

The VM running the control plane has 2 CPUs and 8 GB of RAM. The one running the worker node has 2 CPUs and 4 GB of RAM.

I used the Azure CLI to deploy the resources. 

## Creating a resource group

The first step is to create the resource group that will hold all the resources.

`az group create -n k8slabrg -l westeurope`

## Creating a virtual network

I then deployed a virtual network. I didn't set anything, I just let Azure create a default virtual network, with a default subnet.

`az network vnet create --name k8slabvnet --resource-group k8slabrg --subnet-name default`

## Creating the control plane VM

This Ubuntu VM is more powerful than the worker node. It has 2 CPUs and 8 GB of RAM.

We can specify the image that we want to deploy when creating the VM the `az vm create` command with the `-image` flag. We can be very specific with this option. That's how I did it:

`az vm create --resource-group k8slabrg --name cp1 --image Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest --size Standard_B2ms --vnet-name k8slabvnet --subnet default --admin-username myusername --ssh-key-values ~/.ssh/id_rsa.pub`

I'm using an existing ssh key.

## Creating the worker node

`az vm create --resource-group k8slabrg --name worker1 --image Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest --size Standard_B2s --vnet-name k8slabvnet --subnet default --admin-username myusername --ssh-key-values ~/.ssh/id_rsa.pub`

# The ssh config file

This is something I learned recently, and it's super useful. You can set a config file to make it easier for you to connect to multiple remote systems over SSH.

This file will contain all the hosts you need to connect to with aliases. To connect to the host, simply type `ssh hostname`. You'll save time, since you won't need to type the username and the IP address.

Check [this article](https://linuxize.com/post/using-the-ssh-config-file/) on how to create a config file.

