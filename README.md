### kube-hub repo - practice and training with k8s 
Install [Minikube](https://minikube.sigs.k8s.io/docs/start/) 

```shell
minikube start --driver=docker --cpu=2 --mem=6g
minikube addons enable metrics-server
minikube dashboard
```
Additional minikube addons `minikube addons list`

Install [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/) or create `alias kubectl="minikube kubectl --`

Check kubectl state `kubectl cluster-info`

#### Tasks
[task-1:](https://github.com/dmitriyshub/kube-hub/blob/main/task-1/) simple flask webserver
