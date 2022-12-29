*********************************************************************
[Assign Memory Resources to Containers and Pods << K8s Tutorial Link](https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/)
*********************************************************************
##### Optional step
Create a Namespace `kubectl create namespace task4` \
Check `v1beta1.metrics.k8s.io` with `kubectl get apiservices` output \
Enable metrics `minikube addons enable metrics-server`
*********************************************************************
##### 1.Specify a memory request and a memory limit
To specify a memory request for a Container, include the `resources:requests` field in the Container's resource manifest. \
To specify a memory limit, include `resources:limits` \
The args section in the configuration file provides arguments for the Container when it starts. \
The "--vm-bytes", "150M" arguments tell the Container to attempt to allocate 150 MiB of memory.
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
    args: ["--vm", "1", "--vm-bytes", "150M", "--vm-hang", "1"] # tell the Container to attempt to allocate 150 MiB of RAM
```
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

##### 1. Exceed a Container's memory limit 
Container will attempt to allocate 250 MiB of memory, which is well above the 100 MiB limit.

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
##### 2. Create Pod 
```shell
kubectl apply -f memory-request-limit-2.yaml --namespace=task4 # Create the Pod
kubectl get pod memory-demo-2 --namespace=task4 # View detailed information about the Pod
kubectl get pod memory-demo-2 --output=yaml --namespace=task4 # Get a more detailed view of the Container status

```