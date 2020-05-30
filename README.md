# Ingress issue reproduction

## Ingress Multiple server reproduction

1. Create a minikube instance just for this
   1. `minikube start --driver=kvm2 -p issue-repro`
   2. `minikube addons enable ingress -p issue-repro`
   3. `minikube addons enable dashboard -p issue-repro`
2. connect docker to minikube
   1. `eval $(minikube docker-env -p issue-repro)`
3. docker build . --tag issue-repro/express
4. connect your local port:8080 to minikube:80
   1. `ssh -N -f -M -S /tmp/issue-repro-minikube-sock -L 8080:127.0.0.1:80 -i $(minikube ssh-key -p issue-repro) docker@$(minikube ip -p issue-repro)`
   2. `ssh -S /tmp/issue-repro-minikube-sock -O exit -i $(minikube ssh-key -p issue-repro) docker@$(minikube ip -p issue-repro)` to disconnect
5. apply the k8s config
   1. `kubectl apply -k k8s/base`
6. Open a browser and navigate to [api.dev.tengable.com:8080](http://api.dev.tengable.com:8080)
7. Refresh repeatedly, and you will see that the requests go to both service-one and service-two

## Versions
minikube
```
➜ minikube version
minikube version: v1.10.1
commit: 63ab801ac27e5742ae442ce36dff7877dcccb278
```

kubectl
```
➜ kubectl version --short
Client Version: v1.18.3
Server Version: v1.18.2
```
output from minikube start
```
➜ minikube start -p issue-repro
😄  [issue-repro] minikube v1.10.1 on Debian bullseye/sid
    ▪ MINIKUBE_ACTIVE_DOCKERD=issue-repro
✨  Using the kvm2 driver based on existing profile
👍  Starting control plane node issue-repro in cluster issue-repro
🔄  Restarting existing kvm2 VM for "issue-repro" ...
🐳  Preparing Kubernetes v1.18.2 on Docker 19.03.8 ...
🌟  Enabled addons: dashboard, default-storageclass, ingress, storage-provisioner
🏄  Done! kubectl is now configured to use "issue-repro"
```
Host operating system
```
➜ lsb_release -a
No LSB modules are available.
Distributor ID:	Pop
Description:	Pop!_OS 20.04 LTS
Release:	20.04
Codename:	focal
```
