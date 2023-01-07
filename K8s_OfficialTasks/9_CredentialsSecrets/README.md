*********************************************************************
[Distribute Credentials Securely Using Secrets << K8s Tutorial Link](https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/)
*********************************************************************
#### Convert a Secret to base64
*********************************************************************
* Convert your secret data to a base-64 representation 
```shell
echo -n 'my-app' | base64
echo -n '39528$vdg7Jb' | base64
```
*********************************************************************
#### Create a Secret
*********************************************************************
* Here is a configuration file you can use to create a Secret that holds your username and password
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: test-secret
data:
  username: bXktYXBw
  password: Mzk1MjgkdmRnN0pi
```
*********************************************************************
##### 1. Create Secret
```shell
kubectl apply -f secret.yaml
```
Or Create a Secret directly with kubectl
```shell
kubectl create secret generic test-secret --from-literal='username=my-app' --from-literal='password=39528$vdg7Jb'
```
*********************************************************************
##### 2. Inspect Secret
```shell
kubectl get secret test-secret # View information about the Secret
kubectl describe secret test-secret # View more detailed information about the Secret
```
*********************************************************************
#### Create a Pod that has access to the secret data through a Volume
*********************************************************************
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-test-pod
spec:
  containers:
    - name: test-container
      image: nginx
      volumeMounts:
        # name must match the volume name below
        - name: secret-volume
          mountPath: /etc/secret-volume
  # The secret data is exposed to Containers in the Pod through a Volume.
  volumes:
    - name: secret-volume
      secret:
        secretName: test-secret
```
*********************************************************************
##### 1. Create Pod
```shell
kubectl apply -f secret-pod.yaml

```
*********************************************************************
##### 2. Inspect Pod
```shell
kubectl get pod secret-test-pod
```
*********************************************************************
##### 3. Get inside a Container
```shell
kubectl exec -i -t secret-test-pod -- /bin/bash
```
*********************************************************************
##### 4. secret data is exposed to the Container through a Volume
* mounted under `/etc/secret-volume`
```shell
# Run this in the shell inside the container
ls /etc/secret-volume
```
*********************************************************************
##### 5. Display the contents of the username and password file
```shell
# Run this in the shell inside the container
echo "$( cat /etc/secret-volume/username )"
echo "$( cat /etc/secret-volume/password )"
```
*********************************************************************
#### Define container environment variables using Secret data
*********************************************************************
* Define an environment variable as a key-value pair in a Secret
```shell
kubectl create secret generic backend-user --from-literal=backend-username='backend-admin'
```
* Assign the backend-username value defined in the Secret to the `SECRET_USERNAME` environment variable in the Pod specification.
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: env-single-secret
spec:
  containers:
  - name: envars-test-container
    image: nginx
    env:
    - name: SECRET_USERNAME
      valueFrom:
        secretKeyRef:
          name: backend-user
          key: backend-username
```
*********************************************************************
##### 1. Create Pod
```shell
kubectl create -f pod-single-secret-env-variable.yaml
```
*********************************************************************
##### 2. In your shell, display the content of `SECRET_USERNAME` container environment variable
```shell
kubectl exec -i -t env-single-secret -- /bin/sh -c 'echo $SECRET_USERNAME'
```
*********************************************************************
#### Define container environment variables with data from multiple Secrets 
*********************************************************************
* As with the previous example, create the Secrets first.
```shell
kubectl create secret generic backend-user --from-literal=backend-username='backend-admin'
kubectl create secret generic db-user --from-literal=db-username='db-admin'
```
* Define the environment variables in the Pod specification.
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: envvars-multiple-secrets
spec:
  containers:
  - name: envars-test-container
    image: nginx
    env:
    - name: BACKEND_USERNAME
      valueFrom:
        secretKeyRef:
          name: backend-user
          key: backend-username
    - name: DB_USERNAME
      valueFrom:
        secretKeyRef:
          name: db-user
          key: db-username
```
*********************************************************************
##### 1. Create Pod
```shell
kubectl create -f pod-multiple-secret-env-variable.yaml
```
##### 2. In your shell, display the container environment variables
```shell
kubectl exec -i -t envvars-multiple-secrets -- /bin/sh -c 'env | grep _USERNAME'
```
*********************************************************************
#### Configure all key-value pairs in a Secret as container environment variables
*********************************************************************
* Create a Secret containing multiple key-value pairs
```shell
kubectl create secret generic test-secret --from-literal=username='my-app' --from-literal=password='39528$vdg7Jb'
```
* Use envFrom to define all of the Secret's data as container environment variables. The key from the Secret becomes the environment variable name in the Pod.
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: envfrom-secret
spec:
  containers:
  - name: envars-test-container
    image: nginx
    envFrom:
    - secretRef:
        name: test-secret
```
*********************************************************************
##### 1. Create Pod 
```shell
kubectl create -f pod-secret-envFrom.yaml
```
*********************************************************************
##### 2. In your shell, display username and password container environment variables
```shell
kubectl exec -i -t envfrom-secret -- /bin/sh -c 'echo "username: $username\npassword: $password\n"'
```
*********************************************************************
* [Return to main README](https://github.com/dmitriyshub/kube-hub)
*********************************************************************