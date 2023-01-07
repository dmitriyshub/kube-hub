*********************************************************************
[Configure a Pod to Use a Volume for Storage << K8s Tutorial Link](https://kubernetes.io/docs/tasks/configure-pod-container/configure-volume-storage/)
*********************************************************************
##### Configure a volume for a Pod
* This Pod has a Volume of type emptyDir that lasts for the life of the Pod, even if the Container terminates and restarts.
* Here is the configuration file for the Pod:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: redis
spec:
  containers:
  - name: redis
    image: redis
    volumeMounts:
    - name: redis-storage
      mountPath: /data/redis
  volumes:
  - name: redis-storage
    emptyDir: {}
```
*********************************************************************
##### 1. Create Pod
```shell
kubectl apply -f redis-storage.yaml -n task7
kubectl get pod redis --watch # Verify that the Pod's Container is running, and then watch for changes to the Pod
```
*********************************************************************
##### 2. Open new Terminal
```shell
kubectl exec -it redis -- /bin/bash # In another terminal, get a shell to the running Container
root@redis:/data# cd /data/redis/ # In your shell, go to /data/redis
root@redis:/data/redis# echo Redis > redis-test # and then create a file
```
*********************************************************************
##### 3. list running processes
```shell
root@redis:/data/redis# apt-get update
root@redis:/data/redis# apt-get install procps
root@redis:/data/redis# ps aux
```
*********************************************************************
##### 4. Kill Redis Process
```shell
root@redis:/data/redis# kill <pid>
```
*********************************************************************
##### 5. Verify data  
```shell
kubectl exec -it redis -- /bin/bash # Get a shell into the restarted Container
root@redis:/data/redis# cd /data/redis/ # In your shell, go to /data/redis
root@redis:/data/redis# ls #  verify that test-file is still there
```
*********************************************************************
##### 6. Delete Pod
```shell
kubectl delete pod redis -n task7
```
*********************************************************************
##### In addition to the local disk storage provided by emptyDir, Kubernetes supports many different network-attached storage solutions, including PD on GCE and EBS on EC2, which are preferred for critical data and will handle details such as mounting and unmounting the devices on the nodes. [See Volumes for more details](https://kubernetes.io/docs/concepts/storage/volumes/)
*********************************************************************
##### Configure initContainers
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: redis
spec:
  initContainers:
    - name: git-clone-repo
      image: alpine/git:latest
      command: [ 'sh', '-c', "git clone --single-branch --depth 1 --branch {{BRANCH}} {{git-server.host}}/repo.git /app" ]
      volumeMounts:
        - mountPath: /app
          name: repo
  containers:
    - name: secured-image
      image: secured-image:0.0.1
      volumeMounts:
        - mountPath: /app
          name: repo
  volumes:
    - name: repo
      emptyDir: {}
```
*********************************************************************
##### [Return to main README](https://github.com/dmitriyshub/kube-hub)
*********************************************************************