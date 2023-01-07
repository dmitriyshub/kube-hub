*********************************************************************
[Distribute Credentials Securely Using Secrets << K8s Tutorial Link](https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/)
*********************************************************************
##### Convert a Secret to base64
* Convert your secret data to a base-64 representation 
```shell
echo -n 'my-app' | base64
echo -n '39528$vdg7Jb' | base64
```
##### Create a Secret
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
##### Create a Pod that has access to the secret data through a Volume
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
[Return to main README](https://github.com/dmitriyshub/kube-hub)
*********************************************************************