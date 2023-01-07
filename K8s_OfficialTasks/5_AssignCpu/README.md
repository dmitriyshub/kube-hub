*********************************************************************
[Assign CPU Resources to Containers and Pods << K8s Tutorial Link](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/)
*********************************************************************
#### Optional step
* Create a Namespace `kubectl create namespace task5` 
* Check `v1beta1.metrics.k8s.io` with `kubectl get apiservices` output 
* Enable metrics `minikube addons enable metrics-server`
*********************************************************************
#### Specify a CPU request and a CPU limit 
* To specify a CPU request for a container, include the `resources:requests` field in the Container resource manifest
* To specify a CPU limit, include `resources:limits`
* The args section of the configuration file provides arguments for the container when it starts
* In this exercise, you create a Pod that has one container
* The container has a request of 0.5 CPU and a limit of 1 CPU.
* Here is the configuration file for the Pod
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: cpu-demo
  namespace: task5
spec:
  containers:
  - name: cpu-demo-ctr
    image: vish/stress
    resources:
      limits:
        cpu: "1" # container cpu limit
      requests:
        cpu: "0.5" # container cpu minimum
    args: # The -cpus "2" argument tells the Container to attempt to use 2 CPUs
    - -cpus 
    - "2" 
```
*********************************************************************
##### 1. Create Pod
```shell
kubectl apply -f cpu-request-limit.yaml --namespace=task5
```
*********************************************************************
##### 2. Inspect Pod 
```shell
kubectl get pod cpu-demo --namespace=task5 # Verify that the Pod is running
kubectl get pod cpu-demo --output=yaml --namespace=task5 # View detailed information about the Pod
```
*********************************************************************
##### 3. Use `kubectl top` to fetch the metrics for the Pod
```shell
kubectl top pod cpu-demo --namespace=task5
```
*********************************************************************
##### 4. Delete Pod
```shell
kubectl delete pod cpu-demo --namespace=task5
```
*********************************************************************
#### Specify a CPU request that is too big for your Nodes 
* Create a Pod that has a CPU request so big that it exceeds the capacity of any Node in your cluster. 
* The Container requests 100 CPU, which is likely to exceed the capacity of any Node in your cluster.
* Here is the configuration file for a Pod that has one Container.
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: cpu-demo-2
  namespace: cpu-example
spec:
  containers:
  - name: cpu-demo-ctr-2
    image: vish/stress
    resources:
      limits:
        cpu: "100"
      requests:
        cpu: "100"
    args:
    - -cpus
    - "2"
```
*********************************************************************
##### 1. Create Pod
```shell
kubectl apply -f cpu-request-limit-2.yaml --namespace=task5
```
*********************************************************************
##### 2. Inspect od
```shell
kubectl get pod cpu-demo-2 --namespace=task5
kubectl describe pod cpu-demo-2 --namespace=task5 
```
*********************************************************************
##### 3. Delete Pod
```shell
kubectl delete pod cpu-demo-2 --namespace=task5
```
*********************************************************************
##### Motivation for CPU requests and limits
* The Pod can have bursts of activity where it makes use of CPU resources that happen to be available
* The amount of CPU resources a Pod can use during a burst is limited to some reasonable amount
*********************************************************************
##### Delete Namespace
```shell
kubectl delete namespace task4
```
*********************************************************************
##### [Return to main README](https://github.com/dmitriyshub/kube-hub)
*********************************************************************