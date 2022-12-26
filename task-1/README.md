#### Deploy your own app

1. Build a simple Flask webserver in a Docker container (can be found in `05_simple_webserver`).
2. Push the image to a **public** container registry (e.g. ERC).
3. Change the `deployment.yaml` manifest according to your image. 
4. Apply your changes.
5. You can use [`kubectl port-forward`](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/) command to forward specific pod and port to your local machine, so you can visit the app under the `localhost:<port>` address. This type of connection can be useful for pod debugging and obviously should not be used outside the borders of the development team.
   To do so, perform:

```shell
kubectl port-forward <pod-name> <local-port>:<pod-port> 
```
