*********************************************************************
[HorizontalPodAutoscaler Walkthrough << K8s Tutorial Link](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/)
*********************************************************************
##### 1. Run and expose php-apache server
*********************************************************************
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: php-apache
spec:
  selector:
    matchLabels:
      run: php-apache
  template:
    metadata:
      labels:
        run: php-apache
    spec:
      containers:
      - name: php-apache
        image: registry.k8s.io/hpa-example
        ports:
        - containerPort: 80
        resources:
          limits:
            cpu: 500m
          requests:
            cpu: 200m
---
apiVersion: v1
kind: Service
metadata:
  name: php-apache
  labels:
    run: php-apache
spec:
  ports:
  - port: 80
  selector:
    run: php-apache
```
*********************************************************************
##### 2. Create Horizontal Pod Autoscaler
*********************************************************************
```yaml
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  name: php-apache
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: php-apache
  minReplicas: 1
  maxReplicas: 100
  targetCPUUtilizationPercentage: 50
```
*********************************************************************
##### 3. Increase the load
*********************************************************************
* Run this in a separate terminal
* so that the load generation continues and you can carry on with the rest of the steps
```shell
kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"
```
*********************************************************************
##### 4. Monitor for Changes
*********************************************************************
```shell
kubectl get hpa php-apache --watch
kubectl get deployment php-apache
```
*********************************************************************
##### Stop generating load and Monitor
*********************************************************************
```shell
kubectl get hpa php-apache --watch
```
* In the terminal where you created the Pod that runs a busybox image, terminate the load generation by typing `<Ctrl> + C`
```shell
kubectl delete pod load-generator
```
*********************************************************************
##### [Return to main README](https://github.com/dmitriyshub/kube-hub)
*********************************************************************