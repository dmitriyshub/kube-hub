*********************************************************************
#### 1. Install [Minikube](https://minikube.sigs.k8s.io/docs/start/)
```shell
#Linux Binary Installation x86-64
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```
*********************************************************************
#### 2. Start Minikube Cluster and Dashboard

```shell
minikube start --kubernetes-version=v1.28.0 --driver=docker --cpus=2 --memory=6g --nodes=2 
# Choose K8s version, CRI, CPU, RAM and Number of Nodes 
# driver = hyperv | docker | containerd | etc
minikube addons enable metrics-server
minikube dashboard
```
##### More Minikube Options
Check all options for [`minikube start [option]`](https://minikube.sigs.k8s.io/docs/commands/start/) \
Additional minikube addons `minikube addons list` \
Change Node RAM `minikube config set memory <9001>` 

*********************************************************************
#### 3. Download and Install [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
##### Install bin Kubectl
```shell
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# Optional steps
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
```
If valid, the output is: `kubectl: OK`
```shell
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
```
##### **Use minikube kubectl and Create `alias`** 
```shell 
alias kubectl="minikube kubectl --
```
Check kubectl state `kubectl cluster-info`

*********************************************************************

#### 5. Pause | Stop | Delete - Minikube
```shell
minikube pause
minikube unpause
minikube stop
minikube delete --all
```
*********************************************************************
#### Optional Steps
Install and Use [Lens Dashboard IDE](https://docs.k8slens.dev/getting-started/install-lens/) Instead `minikube dashboard`
*********************************************************************

[Return to main README](https://github.com/dmitriyshub/kube-hub)
*********************************************************************