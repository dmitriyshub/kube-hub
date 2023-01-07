*********************************************************************
[Run a Stateless Application Using a Deployment << K8s Tutorial Link](https://kubernetes.io/docs/tasks/run-application/run-stateless-application-deployment/)
*********************************************************************
##### 1. Create deployment
```shell
kubectl apply -f deployment.yaml
kubectl describe deployment nginx-deployment
kubectl get pods -l app=nginx
kubectl describe pod <pod-name>
```
*********************************************************************
##### 2. Update deployment
```yaml
spec:
  containers:
  - name: nginx
    image: nginx:1.16.1 # Update from 1.14.2 to 1.16.1
```
```shell
kubectl apply -f deployment.yaml
kubectl get pods -l app=nginx
```
*********************************************************************
##### 3. Scale deployment
```yaml
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 4 # Update the replicas from 2 to 4
```
```shell
kubectl apply -f deployment.yaml
kubectl get pods -l app=nginx
```
*********************************************************************
##### 4. Add Service
```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-deployment-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
```
```shell
kubectl apply -f deployment.yaml
```
*********************************************************************
##### 5. Delete deployment 
```shell
kubectl delete deployment nginx-deployment
```
or
```shell
kubectl delete -f deployment.yaml
```
*********************************************************************
##### [Return to main README](https://github.com/dmitriyshub/kube-hub)
*********************************************************************