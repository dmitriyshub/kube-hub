*********************************************************************
#### Kube-Hub Repository - Practice and Training with K8s
*********************************************************************
##### 1. Install [Minikube](https://minikube.sigs.k8s.io/docs/start/) 
##### 2. Start Minikube Cluster and Dashboard

  [Check other options for `minikube start [option]`](https://minikube.sigs.k8s.io/docs/commands/start/)

```shell
minikube start --driver=<container-runtime> --cpus=2 --memory=6g --nodes=2 # choose CRI, CPU, RAM and Number of Nodes 
# container-runtimes = hyperv | docker | containerd | etc
minikube addons enable metrics-server
minikube dashboard
```
Additional minikube addons `minikube addons list`

##### 3. Install [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
**or create** `alias kubectl="minikube kubectl --`

Check kubectl state `kubectl cluster-info`

##### 4. Choose [Kubernetes Tasks](https://kubernetes.io/docs/tasks/) 
*********************************************************************
##### My K8s Tasks

[Run a Stateless Application Using a Deployment](https://github.com/dmitriyshub/kube-hub/tree/main/Kubernetes_Tasks/1_StatelessApp) \
[Use Port Forwarding to Access Applications in a Cluster](https://github.com/dmitriyshub/kube-hub/tree/main/Kubernetes_Tasks/2_PortForward) \
[Use a Service to Access an Application in the Cluster](https://kubernetes.io/docs/tasks/access-application-cluster/service-access-application-cluster/) 

##### My Other Tasks
[Simple Flask Webserver](https://github.com/dmitriyshub/kube-hub/blob/main/Other_Tasks/1_SimpleWebserver/)

*********************************************************************


