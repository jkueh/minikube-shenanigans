# Jordan's Local Kubernetes Guide
*Powered by Minikube*

Minikube allows you to create a simple Kubernetes cluster on your local machine,
to allow you to deploy applications with `kubectl`.

*Note: This guide is written for MacOS. Linux users, please refer to
[the Linux Markdown document](LINUX.md).*

## Getting Started

### Step 0: Install Dependencies

The only thing you need to start kicking off scripts is `make`. This can be
installed via `brew install automake`.

After you've done that, run `make bootstrap`. This installs `minikube`, and the
Kubernetes CLI tool `kubectl`, as well as a few other bits and pieces to get it
running smoothly on your machine.

### Step 1: Create Your First Cluster

Well, this is what you came for! Run `make cluster`.

It will take the VM a few minutes to create, so go grab a coffee! ☕

This isn't a fully distributed or production-ready Kubernetes cluster; What it's
doing in the background is creating the components of a Kubernetes cluster on a
single virtual machine on your system.

Run `minikube dashboard` to check out the Kubernetes dashboard.

### Step 2: Deploy Your Application

One of the fun parts about Kubernetes is the ability to throw things at it, and
watch it work out what to do with it.

With that in mind, run `make deploy`, and visit "Deployments" in the Kubernetes
dashboard - You'll be able to see the deployment being created!

`make service_open` will open the link in your browser; Alternatively you can
run `make service_url` to see the URL.
A message should appear in the browser :)

`curl` it a few times, and you should see responses from different pods:

```Shell
for i in {1..5};do
  curl "$(make service_url)";done
done
```

But now that it's deployed, it's time to have a bit more fun with it...

### Step 3: Breaking Things For Fun And Profit

... Okay, maybe not profit. But still fun.

In a separate window, run `watch -n 1 -- kubectl get pods`.

If you don't have `watch` installed, run
`while true;do clear;kubectl get pods;sleep 1;done`.

If that doesn't want to cooperate with you, run `kubectl get pods -w`.

After you've run one of the above commands, we can start randomly deleting pods
and seeing what happens; Run `make chaos` in a new window and watch the pods
cycle through!

### Step 4: Scaling to Deal With Shenanigans

Sometimes we need to bump the number of pods we have available to deal with
chaos (regardless of who caused it); Open up the `k8s/deployment.yml` file and
change the `replicas` value to `5` - or if you're feeling adventurous, `50` or
higher.

Once you're done, run `make deploy` and watch the changes roll out 🚀

### Step 4: Cleaning Up

`make uncluster` will stop and delete the Minikube cluster. All done! ✅

### Other Commands / Make Targets

```Shell
# Redeploy the cluster to start from scratch
make recluster

# Redeploy the nginx application by removing the existing deployment
make redeploy

# Manual minikube delete step (For example if there are issues stopping
# minikube)
minikube delete
```

## Glossary

**minikube**: A command line utility to allow you to create and manage a local
VM that runs Kubernetes.

**kubectl**: A command-line utility that allows you to interact with a
Kubernetes cluster by deploying resources to it, or inspecting what's running
inside the cluster.

**Pod**: A Kubernetes resource that defines one or more containers, often
deployed alongside other pods running the same set of containers.
In this case, we've created our pods with a Deployment.

**Deployment**: A Kubernetes resources that defines a set of pods, as well as
additional properties in relation to the deployment of those pods.

## Caveats

Some things aren't supported out of the box by Minikube, such as
LoadBalancer-type services, as there is a high probability that there is no load 
balancer provisioning system
on your local machine.
