*********************************************************************
#### Kube-Hub Repository - Practice and Training with K8s
*********************************************************************
##### 1. Install [Minikube](https://minikube.sigs.k8s.io/docs/start/)
```shell
#Linux Binary Installation x86-64
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```
*********************************************************************
##### 2. Start Minikube Cluster and Dashboard
```shell
minikube start --kubernetes-version=v1.28.0 --driver=docker --cpus=2 --memory=6g --nodes=2 
# Choose K8s version, CRI, CPU, RAM and Number of Nodes 
# driver = hyperv | docker | containerd | etc
minikube addons enable metrics-server
minikube dashboard
```
Check all options for [`minikube start [option]`](https://minikube.sigs.k8s.io/docs/commands/start/) \
Additional minikube addons `minikube addons list` \
Change Node RAM `minikube config set memory <9001>`
*********************************************************************
##### 3. Install [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
**or create** `alias kubectl="minikube kubectl --`
Check kubectl state `kubectl cluster-info`
*********************************************************************
##### 4. Choose [Kubernetes Tasks](https://kubernetes.io/docs/tasks/) 
*********************************************************************
##### My Official K8s Tasks
* [Run a Stateless Application Using a Deployment](https://github.com/dmitriyshub/kube-hub/tree/main/Kubernetes_Tasks/1_StatelessApp) 
* [Use Port Forwarding to Access Applications in a Cluster](https://github.com/dmitriyshub/kube-hub/tree/main/Kubernetes_Tasks/2_PortForward) 
* [Use a Service to Access an Application in the Cluster](https://github.com/dmitriyshub/kube-hub/tree/main/Kubernetes_Tasks/3_ServiceAccess) 
* [Assign Memory Resources to Containers and Pods](https://github.com/dmitriyshub/kube-hub/tree/main/Kubernetes_Tasks/4_AssignMemory)
* [Assign CPU Resources to Containers and Pods](https://github.com/dmitriyshub/kube-hub/tree/main/Kubernetes_Tasks/5_AssignCpu)
* [Configure Liveness, Readiness and Startup Probes](https://github.com/dmitriyshub/kube-hub/tree/main/Kubernetes_Tasks/6_LivenessReadiness)
*********************************************************************
##### My Other K8s Tasks
* [Simple Flask Webserver](https://github.com/dmitriyshub/kube-hub/blob/main/Other_Tasks/1_SimpleWebserver)
* [Zero downtime deployment](https://github.com/dmitriyshub/kube-hub/tree/main/Other_Tasks/2_ZeroDowntimeDeployment)

*********************************************************************
