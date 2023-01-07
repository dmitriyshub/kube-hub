*********************************************************************
#### Zero- downtime-deployment-demo
*********************************************************************
##### 1. Configure Container Registry
##### AWS ECR
Create AWS access and secret keys, edit `~/.aws/*` files or use AWS tool: `aws configure`
##### GitHub Container Registry
Create GitHub classic token, export to env variable `export CR_PAT=YOUR_TOKEN`
*********************************************************************
##### 2. Deploy public ecr (Only for AWS skip this step if GitHub chosen)
```shell
terraform init
terraform plan
terraform apply -auto-approve
```
*********************************************************************
##### 3. Build Docker Image and Push it to Public Container Repository
##### AWS ECR
```shell
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/s2q9x3z0
docker build -t public.ecr.aws/r7m7o9d4/dmitriyshub-zero-downtime-app:0.0.1 .
docker push public.ecr.aws/s2q9x3z0/dmitriyshub-zero-downtime-app:0.0.1
```
##### GitHub Container Registry
```shell
echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin
docker build -t ghcr.io/dmitriyshub/zero-downtime-app:0.0.1 .
docker push ghcr.io/OWNER/IMAGE_NAME:0.0.1
```
[Change Visibility to Public](https://docs.github.com/en/packages/learn-github-packages/configuring-a-packages-access-control-and-visibility)

*********************************************************************
##### 4. Change `image:version` in `deployment.yaml` file
```yaml
containers:
  - name: simple-webserver
    image: public.ecr.aws/<number>/<image_name>:<version>
```
*********************************************************************
##### 5. Apply Changes
```shell
kubectl create namespace zero-downtime
kubectl apply -f deployment.yaml -n zero-downtime
```
*********************************************************************
##### 6. Generate some load 
```shell
kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never --namespace zero-downtime -- /bin/sh -c "while sleep 0.2; do (wget -q -O- http://simple-webserver-service:8080 &); done"
```
*********************************************************************
##### 7. During the load test, perform a rolling update to a new version of the app (new built Docker image)
* Change the Python code so it can be seen clearly when you are responded from the new app version. e.g. return Hello world 2 instead of Hello world
```yaml
containers:
  - name: simple-webserver
    image: public.ecr.aws/r7m7o9d4/dmitriyshub-zero-downtime-app:0.0.2
```
*********************************************************************
##### 8. Observe how during rolling update, some requests are failing
*********************************************************************
##### 9. Use the /ready endpoint and add a readinessProbe to gain zero-downtime rolling update, which means, all user requests are being served, even during the update
```yaml
readinessProbe:
 httpGet:
  path: /ready
  port: 8080
 initialDelaySeconds: 5
 periodSeconds: 3
```
*********************************************************************
[Return to main README](https://github.com/dmitriyshub/kube-hub)
*********************************************************************