*********************************************************************
[Assign Memory Resources to Containers and Pods << K8s Tutorial Link](https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/)
*********************************************************************
##### Optional step
Create a Namespace `kubectl create namespace task4` \
Check `v1beta1.metrics.k8s.io` with `kubectl get apiservices` output \
Enable metrics `minikube addons enable metrics-server`
*********************************************************************
##### Specify a memory request and a memory limit
* To specify a memory request for a Container, include the `resources:requests` field in the Container's resource manifest
* To specify a memory limit, include `resources:limits` 
* The args section in the configuration file provides arguments for the Container when it starts
* Create a Pod that has one Container. The Container has a memory request of 100 MiB and a memory limit of 200 MiB
* Here's the configuration file for the Pod
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: memory-demo
  namespace: task4
spec:
  containers:
  - name: memory-demo-ctr
    image: polinux/stress
    resources:
      requests:
        memory: "100Mi"
      limits:
        memory: "200Mi"
    command: ["stress"]
    args: ["--vm", "1", "--vm-bytes", "150M", "--vm-hang", "1"] # "--vm-bytes", "150M" arguments tell the Container to attempt to allocate 150 MiB of RAM
```
*********************************************************************
##### 1. Create Pod
```shell
kubectl apply -f memory-request-limit.yaml -n task4 # Create the Pod
kubectl get pod memory-demo --namespace=task4 # Verify that the Pod Container is running
kubectl get pod memory-demo --output=yaml --namespace=task4 # View detailed information about the Pod
```
*********************************************************************
##### 2. Run `kubectl top` to fetch the metrics for the pod
```shell
kubectl top pod memory-demo --namespace=task4
```
*********************************************************************
##### 3. Delete Pod
```shell
kubectl delete pod memory-demo --namespace=task4
```
*********************************************************************
##### Exceed a Container's memory limit 
Create a Pod that attempts to allocate more memory than its limit. \
Here is the configuration file for a Pod that has one Container with a memory request of 50 MiB and a memory limit of 100 MiB
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: memory-demo-2
  namespace: task4
spec:
  containers:
  - name: memory-demo-2-ctr
    image: polinux/stress
    resources:
      requests:
        memory: "50Mi"
      limits:
        memory: "100Mi"
    command: ["stress"]
    args: ["--vm", "1", "--vm-bytes", "250M", "--vm-hang", "1"] 
```
*********************************************************************
##### 1. Create Pod 
```shell
kubectl apply -f memory-request-limit-2.yaml --namespace=task4 # Create the Pod
```
*********************************************************************
##### 2. Inspect pod 
```shell
kubectl get pod memory-demo-2 --namespace=task4 # View detailed information about the Pod
kubectl get pod memory-demo-2 --output=yaml --namespace=task4 # Get a more detailed view of the Container status
kubectl get pod memory-demo-2 --namespace=task4 # Repeat this command several times to see that the Container is repeatedly killed and restarted
kubectl describe pod memory-demo-2 --namespace=task4 # View detailed information about the Pod history
kubectl describe nodes # View detailed information about your cluster's Nodes:
```
*********************************************************************
##### 3. Delete Pod
```shell
kubectl delete pod memory-demo-2 --namespace=task4 # Delete your Pod
```
*********************************************************************
##### Specify a memory request that is too big for your Nodes
* Create a Pod that has a memory request so big that it exceeds the capacity of any Node in your cluster
* Here is the configuration file for a Pod that has one Container with a request for 1000 GiB of memory, which likely exceeds the capacity of any Node in your cluster
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: memory-demo-3
  namespace: mem-example
spec:
  containers:
  - name: memory-demo-3-ctr
    image: polinux/stress
    resources:
      requests:
        memory: "1000Gi"
      limits:
        memory: "1000Gi"
    command: ["stress"]
    args: ["--vm", "1", "--vm-bytes", "150M", "--vm-hang", "1"]
```
*********************************************************************
##### 1. Create Pod
```shell
kubectl apply -f memory-request-limit-3.yaml --namespace=task4 # Create Pod
```
*********************************************************************
##### 2. Inspect Pod
```shell
kubectl get pod memory-demo-3 --namespace=task4 # View the Pod status
kubectl describe pod memory-demo-3 --namespace=task4 # View detailed information about the Pod, including events
```
*********************************************************************
##### 3. Delete Pod
```shell
kubectl delete pod memory-demo-3 --namespace=task4
```
*********************************************************************
##### Memory units 
* The memory resource is measured in bytes. 
* You can express memory as a plain integer or a fixed-point integer with one of these suffixes: E, P, T, G, M, K, Ei, Pi, Ti, Gi, Mi, Ki.
* For example, the following represent approximately the same value
```text
128974848, 129e6, 129M, 123Mi
```
*********************************************************************
##### Delete Namespace
```shell
kubectl delete namespace task4
```
*********************************************************************