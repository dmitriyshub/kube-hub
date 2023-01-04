*********************************************************************
[Configure a Pod to Use a PersistentVolume for Storage << K8s Tutorial Link](https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/)
*********************************************************************
##### Create an index.html file on your Node
*********************************************************************
```shell
minikube ssh # connect to cluster
sudo mkdir /mnt/data # In your shell on that Node, create a /mnt/data directory
sudo sh -c "echo 'Hello from Kubernetes storage' > /mnt/data/index.html" # In the /mnt/data directory, create an index.html file
cat /mnt/data/index.html # Test that the index.html file exists
```
*********************************************************************
##### Create a PersistentVolume
*********************************************************************
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
  storageClassName: manual # It defines the StorageClass name manual for the PersistentVolume, which will be used to bind PersistentVolumeClaim requests to this PersistentVolume.
  capacity:
    storage: 10Gi # # The configuration also specifies a size of 10 gibibytes
  accessModes:
    - ReadWriteOnce # and an access mode of ReadWriteOnce, which means the volume can be mounted as read-write by a single Node
  hostPath:
    path: "/mnt/data" # The configuration file specifies that the volume is at /mnt/data on the cluster's Node
```
*********************************************************************
##### 1. Create Persistent Volume
```shell
kubectl apply -f pv-volume.yaml -n task8
```
*********************************************************************
##### 2. Inspect Persistent Volume
```shell
kubectl get pv task-pv-volume
```
*********************************************************************
##### Create a PersistentVolumeClaim 
*********************************************************************
* Pods use PersistentVolumeClaims to request physical storage
* Create a PersistentVolumeClaim that requests a volume of at least three gibibytes that can provide read-write access for at least one Node.
* Here is the configuration file for the PersistentVolumeClaim

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: task-pv-claim
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 3Gi
```
*********************************************************************
##### 1. Create Persistent Volume Claim
```shell
kubectl apply -f pv-volume.yaml -n task8
```
*********************************************************************
##### 2. Inspect Persistent Volume Claim
```shell
kubectl get pv task-pv-volume -n task8
kubectl get pvc task-pv-claim -n task8
```
*********************************************************************
##### Create a Pod
*********************************************************************
* create a Pod that uses your PersistentVolumeClaim as a volume
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: task-pv-pod
spec:
  volumes:
    - name: task-pv-storage
      persistentVolumeClaim:
        claimName: task-pv-claim
  containers:
    - name: task-pv-container
      image: nginx
      ports:
        - containerPort: 80
          name: "http-server"
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: task-pv-storage
```
##### 1. Create Pod
```shell
kubectl apply -f pv-pod.yaml -n task8
```
*********************************************************************
##### 2. Inspect Pod
```shell
kubectl get pod task-pv-pod -n task8
```
*********************************************************************
##### 3. Get a shell to the container running in your Pod
```shell
kubectl exec -it task-pv-pod -- /bin/bash # Get a shell to the container running in your Pod
apt update
apt install curl
curl http://localhost/
```
*********************************************************************
##### Clean Resources
*********************************************************************
```shell
kubectl delete pod task-pv-pod -n task8
kubectl delete pvc task-pv-claim -n task8
kubectl delete pv task-pv-volume -n task8
```
*********************************************************************
##### [See Volumes for more details](https://kubernetes.io/docs/concepts/storage/volumes/)
*********************************************************************
[Return to main README](https://github.com/dmitriyshub/kube-hub)
*********************************************************************