*********************************************************************
[Configure Liveness, Readiness and Startup Probes << K8s Tutorial Link](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
*********************************************************************
#### Define a liveness command 
* Create a Pod that runs a container based on the registry.k8s.io/busybox image
* Here is the configuration file for the Pod
```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    test: liveness
  name: liveness-exec
spec:
  containers:
  - name: liveness
    image: registry.k8s.io/busybox
    args: # When the container starts, it executes this command 
    - /bin/sh
    - -c
    - touch /tmp/healthy; sleep 30; rm -f /tmp/healthy; sleep 600 
    livenessProbe:
      exec:
        command: # kubelet executes the command cat /tmp/healthy in the target container
        - cat
        - /tmp/healthy # If the command returns a non-zero value, the kubelet kills the container and restarts it
      initialDelaySeconds: 5 # tells the kubelet that it should wait 5 seconds before performing the first probe
      periodSeconds: 5 # kubelet should perform a liveness probe every 5 seconds
```
* For the first 30 seconds of the container's life, there is a /tmp/healthy file. 
* So during the first 30 seconds, the command cat /tmp/healthy returns a success code. 
* After 30 seconds, cat /tmp/healthy returns a failure code.
```shell
/bin/sh -c "touch /tmp/healthy; sleep 30; rm -f /tmp/healthy; sleep 600"
```
*********************************************************************
##### 1. Create Pod
```shell
kubectl apply -f exec-liveness.yaml
```
*********************************************************************
##### 2. View the Pod events
```shell
kubectl describe pod liveness-exec
kubectl get pod liveness-exec
```
*********************************************************************
##### 3. Delete Pod
```shell
kubectl delete -f exec-liveness.yaml
```
*********************************************************************
#### Define a liveness HTTP request 
* Another kind of liveness probe uses an HTTP GET request
* Create Pod that runs a container based on the registry.k8s.io/liveness image.
```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    test: liveness
  name: liveness-http
spec:
  containers:
  - name: liveness
    image: registry.k8s.io/liveness
    args:
    - /server
    livenessProbe:
      httpGet: # kubelet sends an HTTP GET request to the server that is running in the container
        path: /healthz # If the handler returns a failure code, the kubelet kills the container and restarts it
        port: 8080 # listening on port 8080
        httpHeaders:
        - name: Custom-Header
          value: Awesome
      initialDelaySeconds: 3 # kubelet that it should wait 3 seconds before performing the first probe
      periodSeconds: 3 # kubelet should perform a liveness probe every 3 seconds
```
* Any code greater than or equal to 200 and less than 400 indicates success. Any other code indicates failure.
* For the first 10 seconds that the container is alive, the /healthz handler returns a status of 200. After that, the handler returns a status of 500.
```go
http.HandleFunc("/healthz", func(w http.ResponseWriter, r *http.Request) {
    duration := time.Now().Sub(started)
    if duration.Seconds() > 10 {
        w.WriteHeader(500)
        w.Write([]byte(fmt.Sprintf("error: %v", duration.Seconds())))
    } else {
        w.WriteHeader(200)
        w.Write([]byte("ok"))
    }
})
```
*********************************************************************
##### 1. Create Pod
```shell
kubectl apply -f http-liveness.yaml
```
*********************************************************************
##### 2. Inspect Pod
* After 10 seconds, view Pod events to verify that liveness probes have failed and the container has been restarted
```shell
kubectl describe pod liveness-http
```
*********************************************************************
##### 3. Delete Pod
```shell
kubectl delete -f http-liveness.yaml
```
*********************************************************************
#### Define a TCP liveness probe 
* A third type of liveness probe uses a TCP socket.
* kubelet will attempt to open a socket to your container on the specified port
* If it can establish a connection, the container is considered healthy, if it can't it is considered a failure
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: goproxy
  labels:
    app: goproxy
spec:
  containers:
  - name: goproxy
    image: registry.k8s.io/goproxy:0.1
    ports:
    - containerPort: 8080
    readinessProbe:
      tcpSocket: # This will attempt to connect to the goproxy container
        port: 8080 #  on port 8080
      initialDelaySeconds: 5 # kubelet will send the first readiness probe 5 seconds after the container starts
      periodSeconds: 10 # The kubelet will continue to run this check every 10 seconds
    livenessProbe:
      tcpSocket: # will attempt to connect to the goproxy container
        port: 8080 # on port 8080
      initialDelaySeconds: 15 # kubelet will run the first liveness probe 15 seconds after the container starts
      periodSeconds: 20 # The kubelet will continue to run this check every 20 seconds
```
*********************************************************************
##### 1. Create Pod
```shell
kubectl apply -f tcp-liveness-readiness.yaml
```
*********************************************************************
##### 2. After 15 seconds, view Pod events to verify that liveness probes:
```shell
kubectl describe pod goproxy
```
*********************************************************************
##### 3. Delete Pod
```shell
kubectl delete -f tcp-liveness-readiness.yaml
```
*********************************************************************