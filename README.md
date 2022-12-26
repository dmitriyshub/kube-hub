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

#### Links
[Kubernetes Tasks](https://kubernetes.io/docs/tasks/) \
[Run a Stateless Application Using a Deployment](https://kubernetes.io/docs/tasks/run-application/run-stateless-application-deployment/) \
[Use Port Forwarding to Access Applications in a Cluster](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/) \
[Use a Service to Access an Application in the Cluster](https://kubernetes.io/docs/tasks/access-application-cluster/service-access-application-cluster/) 

#### Tasks
[task-1:](https://github.com/dmitriyshub/kube-hub/blob/main/task-1/) simple flask webserver
