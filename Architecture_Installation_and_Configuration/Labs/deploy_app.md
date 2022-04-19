# Deploying a simple application

For this lab we'll deploy an NGINX web server. This will happen at the control plane.

We'll create a **Kubernetes Deployment** configuration, which instructs Kubernetes how to create and update instances of our application. Once the Deployment is created, the Kubernetes control plane schedules the application instances included in that Deployment to run on individual Nodes in the cluster.

`kubectl create deployment nginx --image=nginx`

The command above will pull an NGINX image and create a container. 

To check the deployment we run the following:

`kubectl get deployments`

And to see the details about this specific deployment, we run the following:

`kubectl describe deployment nginx`

![kubectl describe deployment](../media/kubectldescribedeploymentnginx.png)

We can see the steps the cluster took to pull and deploy the nginx app by running `kubectl get events`

![kubectl get events](../media/getevents.png)

## Deploying an app from a manifest file

We can define our deployment declaratively in a yaml file and post it to the api-server. For this lab, we'll create a yaml file from the output of our deployment.

We'll output the deployment in yaml format and send it to a file, like so:

`kubectl get deployment nginx -o yaml > first.yaml`

In order to use this file for later deployments, we need to do some editing. We'll remove the `creationTimestamp`, `resourceVersion`, and `uid` lines. We also need to remove everything after `status`, including the word `status` itself. We'll also add port information for the container, so we can access it later. Check lines *34* and *35* in the file.

The edited yaml file, ready to be used for deployments, is [here](../yaml_files/first.yaml).

We'll delete the existing deployment and create a new one from our yaml file.

`kubectl delete deployment nginx`
`kubectl create -f first.yaml`

## Creating a service object that exposes the deployment

Although each pod has a unique IP address, those IP addresses are not exposed outside the cluster without a Service. The `kubectl expose` command will take a deployment and expose it as a new Kubernetes Service.

`kubectl expose deployment/nginx`

We can verify the service by running `kubectl get svc`.

`kubectl get svc nginx`

This will provide us the `ClusterIP`. This is a cluster internal IP address, which means the service is only reachable from within the cluster. This IP address is provided by Calico.

The pods in a cluster a exposed through endpoints. To see the pods' endpoints, we run `kubectl get ep`.

`kubectl get ep nginx`

Since we have just one pod running our application now, we'll see just one IP address.

Let's move to our worker node and run a `curl` to see our web server running. We can use either the ClusterIP or the endpoint IP.

![curl](../media/curlnginxep.png)

Now we'll scale up our deployment, from one to three pods. There's a way to do it via the command-line, with `kubectl scale deployment`, but it's not best practice. All changes in deployments should be done via manifest files. We'll do it like that, by updating our [first.yaml](../yaml_files/first.yaml) file. On line 13, where it says `replicas`, we'll write the number 3. We then run the following:

`kubectl replace -f first.yaml`

Let's see our 3 running pods:

`kubectl get pod`

## Access from outside the cluster

We can access a Service from outside the cluster using a DNS add-on or environment variables. We'll expose our Service by using environment variables.

Let's get the list of pods:

`kubectl get pod`

![kubectl get pod](media/../../media/kubectlgetpod.png)

We can choose any of these pods for our next task. I chose the second one, the one that ends in *b6bb*.

We then run `kubectl exec` to run `printenv` inside the pod. Like so:

`kubectl exec nginx-7848d4b86f-kb6bb -- printenv | grep KUBERNETES`

![kubectl exec](../media/kubectlexec.png)

We'll redeploy the nginx Service. We'll need to delete the existing Service first.

`kubectl delete svc nginx`
`kubectl expose deployment nginx --type=LoadBalancer`

The difference from the previous Service is that this one has the `LoadBalancer` type.

The cluster should now be accessible to the outside world.

We'll run `kubectl get svc` again and take note of the port made available for the nginx Service. It's the big number after the colon. In my case it was 30488.

![kubectl get svc](../media/kubectlgetsvc.png)

In the browser, we'll navigate to the worker node's public IP address with the port. We should see the Nginx welcome page.

![Nginx](../media/nginxrunning.png)

## Testing the scalability

We can test the power of Kubernetes by scaling down the deployment to 0 replicas. This will render the web server inaccessible.

`kubectl scale deployment nginx --replicas=0`

We can now scale it up to 2 replicas, and see the web server come back to life.

`kubectl scale deployment nginx --replicas=2`

## Cleaning up everything

Let's delete the deployment, the endpoints and the service.

`kubectl delete deployments nginx`
`kubectl delete ep nginx`
`kubectl delete svc nginx`

**NEXT:** 