*********************************************************************
[Configure a Pod to Use a PersistentVolume for Storage << K8s Tutorial Link](https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/)
*********************************************************************
##### Create a PersistentVolume
* create a hostPath PersistentVolume
* Kubernetes supports hostPath for development and testing on a single-node cluster
* A hostPath PersistentVolume uses a file or directory on the Node to emulate network-attached storage
* In a production cluster, you would not use hostPath
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: task-pv-volume
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"
```
*********************************************************************
##### 1. Create Pod
```shell
kubectl apply -f pv-volume.yaml -n task8

```
*********************************************************************
##### 2. Inspect Pod
```shell
kubectl get pv task-pv-volume

```
*********************************************************************
##### 3. list running processes
```shell

```
*********************************************************************
##### 4. Kill Redis Process
```shell

```
*********************************************************************
##### 5. Verify data  
```shell

```
*********************************************************************
##### 6. Delete Pod
```shell

```
*********************************************************************
##### [See Volumes for more details](https://kubernetes.io/docs/concepts/storage/volumes/)
*********************************************************************
[Return to main README](https://github.com/dmitriyshub/kube-hub)
*********************************************************************