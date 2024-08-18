#!/bin/bash

# Set the variables
rg=k8slabrg
location=uksouth
vnet=k8svnet
subnet=subnet

# Create the resource group
az group create -n $rg -l $location

# Create the virtual network
az network vnet create -g $rg \
        -l $location \
        -n $vnet \
        --address-prefixes 10.10.0.0/16 \
        --subnet-name $subnet \
        --subnet-prefixes 10.10.0.0/27

# Create an NSG and attach it to the Subnet
az network nsg create -n k8s-nsg -g $rg

az network vnet subnet update -n $subnet \
        -g $rg \
        --vnet-name $vnet \
        --network-security-group k8s-nsg

# Create firewall rules that allow SSH and HTTPS
az network nsg rule create -g $rg \
        -n allow-ssh \
        --access allow \
        --destination-address-prefix '*' \
        --destination-port-range 22 \
        --direction inbound \
        --nsg-name k8s-nsg \
        --protocol tcp \
        --source-address-prefix '*' \
        --source-port-range '*' \
        --priority 1000

az network nsg rule create -g $rg \
        -n allow-api-server \
        --access allow \
        --destination-address-prefix '*' \
        --destination-port-range 6443 \
        --direction inbound \
        --nsg-name k8s-nsg \
        --protocol tcp \
        --source-address-prefix '*' \
        --source-port-range '*' \
        --priority 1001

# Create the Control Plane VM

az vm create -n cp1 \
        -g $rg \
        --image Ubuntu2204 \
        --size Standard_B2s \
        --vnet-name $vnet \
        --subnet $subnet \
        --generate-ssh-keys

# Create 2 Worker VMs

for i in 1 2; do
    az vm create -n worker${i} \
            -g $rg \
            --image Ubuntu2204 \
            --size Standard_B2s \
            --vnet-name $vnet \
            --subnet $subnet \
            --generate-ssh-keys
done

