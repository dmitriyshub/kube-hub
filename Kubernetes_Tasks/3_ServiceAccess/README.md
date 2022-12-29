*********************************************************************
[Use a Service to Access an Application in a Cluster << K8s Tutorial Link](https://kubernetes.io/docs/tasks/access-application-cluster/service-access-application-cluster/)
*********************************************************************
![service image](img/service-k8s.png)
*********************************************************************
##### Further reading and doing
Notes:
- _Using a service configuration file_ section (use YAML file instead `kubectl expose` command).
- Use `minikube ip` to get the IP of Minikube "node" and visit the app in `http://<NodeIP>:<NodePort>`
*********************************************************************
Services can be exposed in different ways by specifying a `type` in the ServiceSpec. We will review two types:
- `ClusterIP` (default) - Exposes the Service on an internal IP in the cluster. This type makes the Service only reachable from within the cluster.
- `NodePort` - Exposes the Service on some port of each **Node** in the cluster. Makes a Service accessible from outside the cluster using `<NodeIP>:<NodePort>`.
*********************************************************************
Optional - Create namespace
```shell
kubectl create namespace task3
```
Check Cluster Information
```yaml
kubectl cluster-info
```
#### NodePort
##### 1. Apply hello-app
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-world
spec:
  selector:
    matchLabels:
      run: load-balancer-example
  replicas: 2
  template:
    metadata:
      labels:
        run: load-balancer-example
    spec:
      containers:
        - name: hello-world
          image: gcr.io/google-samples/node-hello:1.0
          ports:
            - containerPort: 8080
              protocol: TCP
```
```shell
kubectl apply -f hello-app.yaml -n task3 
kubectl get deployments hello-world -n task3
kubectl describe deployments hello-world -n task3
kubectl get replicasets -n task3
kubectl describe replicasets -n task3
```
*********************************************************************
##### 2. Add service
```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: hello-world-deployment-service
spec:
  type: NodePort
  selector:
    run: load-balancer-example
  ports:
    - protocol: TCP
      port: 8080
      targetPort: 8080
      nodePort: 30001
```
```shell
kubectl apply -f hello-app.yaml -n task3
kubectl describe services hello-world-deployment-service -n task3
```
or
```shell
kubectl expose deployment hello-world --type=NodePort --name=hello-world-deployment-service -n task3
kubectl describe services hello-world-deployment-service -n task3
```
*********************************************************************
##### 3. Access App
```shell
curl http://<public-node-ip>:<node-port>
```
or with any web browser 
*********************************************************************
##### 3.Delete All
```shell
kubectl delete -f hello-app.yaml
```
or 
```shell
kubectl delete services hello-world-deployment-service -n task3
kubectl delete deployment hello-world -n task3
```
*********************************************************************
#### Or ClusterIP 
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-world
spec:
  selector:
    matchLabels:
      run: load-balancer-example
  replicas: 2
  template:
    metadata:
      labels:
        run: load-balancer-example
    spec:
      containers:
        - name: hello-world
          image: gcr.io/google-samples/node-hello:1.0
          ports:
            - containerPort: 8080
              protocol: TCP
---
apiVersion: v1
kind: Service
metadata:
  name: hello-world-service
spec:
  selector:
    run: load-balancer-example
  ports:
    - protocol: TCP
      port: 8080
      targetPort: 8080
```
```shell
kubectl apply -f hello-app2.yaml -n task3
kubectl port-forward service/hello-world-service 8080:8080 -n task3
```