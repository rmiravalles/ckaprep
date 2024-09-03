# YAML in Kubernetes

Kubernetes uses **YAML files** as inputs for the creation of objects, such as Pods, replicas, deployments, services, etc.

These files, called **manifest files**, follow a similar structure, and must contain four fields: `apiVersion`, `kind`, `metadata`, and `spec`.

```yml
apiVersion: v1  # these are string values
kind: Pod  # these are string values too
metadata:  # this is a dictionary with key-value pairs
  name: myapp  # these fields are indented so they are nested under metadata
  labels:  # this is a dictionary too
    app: myapp  # you can define as many labels as you see fit
    type: front-end
spec:  # this is also a dictionary
  containers:  # this a list or array, as a Pod can have multiple containers
    - name: nginx-container  # the dash (-) represents an item in the list
      image: nginx
```

## apiVersion

The version of the Kubernetes API we're using to create the object. The version will depend on the object we're trying to create.

## kind

This is the kind of object being created. A few examples are listed below, along with the corresponding API version to be used.

| Kind | apiVersion |
| ----------- | ----------- |
| Pod | v1 |
| Service | v1 |
| ReplicaSet | apps/v1 |
| Deployment | apps/v1 |

For more on this, consult the [Kubernetes API documentation](https://kubernetes.io/docs/reference/kubernetes-api/).

## metadata

Metadata is data about the object, such as its name and whatever labels that might be used to describe the object. The data entered here is in the form of a dictionary.

## spec

Here we specify the information Kubernetes will use to deploy the object. Depending on the object, different specs will go in here.
