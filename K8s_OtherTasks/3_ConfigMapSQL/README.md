*********************************************************************
##### MySQL server in Kuberenetes cluster using Deployment
*********************************************************************
##### 1. Create a Secret object containing the root username password for MySQL
```shell
kubectl apply -f mysql-secret.yaml
```
*********************************************************************
##### 2. Deploy the MySQL deployment by applying `mysql-deployment.yaml` configuration file.
Now let's say we want to allow maximum of 50 connection to our DB. 
We would like to find a useful way to "inject" this config to our pre-built `mysql:5.7` image (we surely don't want to build the MySQL image ourselves).
For that, the ConfigMap object can assist. In the mysql Docker image, custom configurations for the MySQL server can be placed in `/etc/mysql/mysql.conf.d` directory, 
any file ends with .cnf under that directory, will be applied as an additional configurations to MySQL. 
*********************************************************************
##### Review the ConfigMap object under mysql-config.yaml. And apply it
*********************************************************************
##### Comment in the two snippets in mysql-deployment.yaml and apply the changes
*********************************************************************
##### Make sure the new configurations applied
*********************************************************************
##### [Further reading and doing](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap)
*********************************************************************
##### [Return to main README](https://github.com/dmitriyshub/kube-hub)
*********************************************************************