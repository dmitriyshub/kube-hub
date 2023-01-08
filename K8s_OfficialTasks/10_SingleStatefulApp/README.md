*********************************************************************
##### [Run a Single-Instance Stateful Application](https://kubernetes.io/docs/tasks/run-application/run-single-instance-stateful-application/)
*********************************************************************
##### 1. Deploy the PV and PVC of the YAML file:
```shell
kubectl apply -f manifests/mysql-pv.yaml
```
*********************************************************************
##### 2. Deploy the contents of the YAML file:
```shell
kubectl apply -f manifests/mysql-deployment.yaml
```
*********************************************************************
##### 3. Display information about the Deployment:
```shell
kubectl describe deployment mysql
```
##### 4. List the pods created by the Deployment:

```shell
kubectl get pods -l app=mysql
```
##### 5. Inspect the PersistentVolumeClaim:
```shell
kubectl describe pvc mysql-pv-claim
```
*********************************************************************
##### Accessing the MySQL instance
*********************************************************************
* Run a MySQL client to connect to the server:

```shell
kubectl run -it --rm --image=mysql:5.6 --restart=Never mysql-client -- mysql -h mysql -ppassword
```
*********************************************************************
##### [Return to main README](https://github.com/dmitriyshub/kube-hub)
*********************************************************************