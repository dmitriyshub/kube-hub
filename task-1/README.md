#### Configure AWS
edit `~/.aws/*` files or use AWS tool: `aws configure`

#### Deploy ecr
```shell
terraform init
terraform plan
terraform apply -auto-approve
```
#### Build and Push Docker image to **public** ecr
```shell
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/r7m7o9d4
docker build -t public.ecr.aws/r7m7o9d4/dmitriyshub-simple-webserver:0.0.1 .
docker push public.ecr.aws/r7m7o9d4/dmitriyshub-simple-webserver:0.0.1
```

#### Modify Deployment yaml file
Change the `deployment.yaml` manifest according to your image. 
```shell
containers:
  - name: simple-webserver
    image: public.ecr.aws/<ecr>/<image>:<0.0.?>
```

#### Deploy the app
```shell
kubectl apply -f deployment.yaml
```

You can use [`kubectl port-forward`](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/) command to forward specific pod and port to your local machine, so you can visit the app under the `localhost:<port>` address. This type of connection can be useful for pod debugging and obviously should not be used outside the borders of the development team.
   To do so, perform:

```shell
kubectl port-forward <pod-name> <local-port>:<pod-port> 
```
