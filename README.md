*********************************************************************
#### Kube-Hub Repository - Practice and Training with K8s Repository
*********************************************************************
#### [Understand Kubernetes Object](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/)
*********************************************************************
* `apiVersion` - Which version of the Kubernetes API you're using to create this object
* `kind` - What kind of object you want to create
* `metadata` - Data that helps uniquely identify the object, including a name string, UID, and optional namespace
* `spec` - What state you desire for the object

Labels are **key/value** pairs that are attached to objects, such as Deployment:
```yaml
"release" : "stable"
"environment" : "dev"
"tier" : "backend"
```
*********************************************************************
#### Switch between clusters
```shell
kubectl config get-clusters
kubectl config get-contexts
kubectl config use-context minikube # minikube
kubectl config use-context arn:aws:eks:<region>:<accountId>:cluster/<name> # EKS
```
*********************************************************************
#### My Docs
*********************************************************************
#### [Minikube and Kubectl Installation and Configuration](https://github.com/dmitriyshub/kube-hub/blob/main/docs/minikubeREADME.md)
*********************************************************************
#### K8s Docs
*********************************************************************
#### [Official Kubernetes Tasks](https://kubernetes.io/docs/tasks/) 
*********************************************************************
#### My Official K8s Tasks
*********************************************************************
- [Run a Stateless Application Using a Deployment](https://github.com/dmitriyshub/kube-hub/tree/main/K8s_OfficialTasks/1_StatelessApp) 
- [Use Port Forwarding to Access Applications in a Cluster](https://github.com/dmitriyshub/kube-hub/tree/main/K8s_OfficialTasks/2_PortForward) 
- [Use a Service to Access an Application in the Cluster](https://github.com/dmitriyshub/kube-hub/tree/main/K8s_OfficialTasks/3_ServiceAccess) 
- [Assign Memory Resources to Containers and Pods](https://github.com/dmitriyshub/kube-hub/tree/main/K8s_OfficialTasks/4_AssignMemory)
- [Assign CPU Resources to Containers and Pods](https://github.com/dmitriyshub/kube-hub/tree/main/K8s_OfficialTasks/5_AssignCpu)
- [Configure Liveness, Readiness and Startup Probes](https://github.com/dmitriyshub/kube-hub/tree/main/K8s_OfficialTasks/6_LivenessReadiness)
- [Configure a Pod to Use a Volume for Storage](https://github.com/dmitriyshub/kube-hub/tree/main/K8s_OfficialTasks/7_PodVolumeStorage)
- [Configure a Pod to Use a PersistentVolume for Storage](https://github.com/dmitriyshub/kube-hub/tree/main/K8s_OfficialTasks/8_PersistantVolume)
- [Distribute Credentials Securely Using Secrets](https://github.com/dmitriyshub/kube-hub/tree/main/K8s_OfficialTasks/9_CredentialsSecrets)
- [Run a Single-Instance Stateful Application](https://github.com/dmitriyshub/kube-hub/tree/main/K8s_OfficialTasks/10_SingleStatefulApp)
- [HorizontalPodAutoscaler Walkthrough](https://github.com/dmitriyshub/kube-hub/tree/main/K8s_OfficialTasks/11_HorizontalPodAutoscaler)
- [Running Automated Tasks with a CronJob](https://github.com/dmitriyshub/kube-hub/tree/main/K8s_OfficialTasks/12_AutomatedCronJobs)
*********************************************************************
#### My Other K8s Tasks
*********************************************************************
- [Simple Flask Webserver](https://github.com/dmitriyshub/kube-hub/blob/main/K8s_OtherTasks/1_SimpleWebserver)
- [Zero downtime deployment](https://github.com/dmitriyshub/kube-hub/tree/main/K8s_OtherTasks/2_ZeroDowntimeDeployment)
- [MySQL server Deployment with ConfigMap](https://github.com/dmitriyshub/kube-hub/tree/main/K8s_OtherTasks/3_ConfigMapSQL)
- [Multi AZ MySql Cluster With helm](https://github.com/dmitriyshub/kube-hub/blob/main/K8s_OtherTasks/4_MultiAzSQLCluster)
- [Stream Pod logs to Elasticsearch databases using FluentD](https://github.com/dmitriyshub/kube-hub/blob/main/K8s_OtherTasks/5_ElasticSearchAndFluentD)
- [EKS cluster tutorial](https://github.com/dmitriyshub/kube-hub/blob/main/K8s_OtherTasks/6_EksCluster)
*********************************************************************