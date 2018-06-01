# Linux Installation

The main README document has steps that will work on MacOS; However there are
still ways to get the cluster up and running on Linux.

Install a hypervisor, `minikube`, and `kubectl` as per
https://kubernetes.io/docs/tasks/tools/install-minikube/.

If necessary, install the machine driver for your hypervisor:
https://github.com/machine-drivers

The `make` target in Step 1 of the main README document attempts to use the
hyperkit driver, so you will need to start it yourself; For example:

```Shell
minikube start --vm-driver kvm2

# Alternatively: Run without a VM.
# Requires sudo access, and will override kubeadm and kubelet on your system.
# Minikube also has suitable warnings about file ownership on ~/.kube and
# ~/.minikube

sudo $(which minikube) start --vm-driver none
```

... Or the supported hypervisor you've installed;
`minikube start --help | grep 'vm-driver'` will show you a list of accepted
values.

From there, `minikube dashboard` will get you to the dashboard, and the rest of
the guide can be followed.
