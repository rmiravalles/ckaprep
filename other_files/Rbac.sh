# To obtain the Control Plane IP address
kubectl cluster-info

# Create a role
kubectl create role pod-deploy-reader --verb=get --verb=list --verb=watch --resource=pods,deployments

# Create a role binding
kubectl create rolebinding pod-deploy-reader-binding --role=pod-deploy-reader --serviceaccount=default:default

# Store the token in a variable
TOKEN=$(kubectl get secret -n default -o json | jq -r '(.items[].data.token)' | base64 --decode | tr -d "\n")

curl -X GET https://10.10.0.4:6443/api/v1/namespaces/default/pods --header "Authorization: Bearer $TOKEN" --cacert /etc/kubernetes/pki/ca.crt