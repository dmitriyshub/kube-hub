*********************************************************************
[Use Port Forwarding to Access Applications in a Cluster << K8s Tutorial Link](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/) 
*********************************************************************
##### 1. Create mongo deployment
```shell
kubectl apply -f mongo-deployment.yaml
kubectl get pods
kubectl get deployment
kubectl get replicaset
kubectl get service mongo
```
*********************************************************************
##### 2. Verify that the MongoDB server is running in the Pod, and listening on port 27017
```shell
kubectl get pods
kubectl get pod <mongo-pod-name> --template='{{(index (index .spec.containers 0).ports 0).containerPort}}{{"\n"}}'
```
*********************************************************************
##### 3. Forward a local port to a port on the Pod
```shell
kubectl port-forward <mongo-pod-name> 28015:27017
```
*********************************************************************
##### 4. Start the MongoDB command line interface
```shell
mongosh --port 28015
```
Inside the db ping request `db.runCommand( { ping: 1 } )`
*********************************************************************
#### 5. Delete mongo deployment
```shell
kubectl delete -f mongo-deployment.yaml
```
*********************************************************************
##### [Return to main README](https://github.com/dmitriyshub/kube-hub)
*********************************************************************