*********************************************************************
#### MultiAz MySql Cluster
*********************************************************************
##### Helm
*********************************************************************
Helm is the package manager for Kubernetes.
The main big 3 concepts of helm are:

- A **Chart** is a Helm package. It contains all the resource definitions necessary to run an application, tool, or service inside of a Kubernetes cluster.
- A **Repository** is the place where charts can be collected and shared.
- A **Release** is an instance of a chart running in a Kubernetes cluster.

[Install](https://helm.sh/docs/intro/install/) the Helm cli if you don't have.

You can familiarize yourself with this tool using [Helm docs](https://helm.sh/docs/intro/using_helm/). 
*********************************************************************
#### Deploy MySQL using Helm
*********************************************************************
How relational databases are deployed in real-life applications?
The following diagram shows a Multi-AZ DB cluster

![MySql Multi Cluster](img/mysql-multi-instance.png)
- With a Multi-AZ DB cluster, MySQL replicates data from the writer DB instance to both of the reader DB instances
- When a change is made on the writer DB instance, it's sent to each reader DB instance
- Acknowledgment from at least one reader DB instance is required for a change to be committed
- Reader DB instances act as automatic failover targets and also serve read traffic to increase application read throughput

Once you have Helm ready, you can add a chart repository. Check [Artifact Hub](https://artifacthub.io/packages/search?kind=0).

Let's review the Helm chart written by Bitnami for MySQL provisioning in k8s cluster.

[https://github.com/bitnami/charts/tree/master/bitnami/mysql/#installing-the-chart](https://github.com/bitnami/charts/tree/master/bitnami/mysql/#installing-the-chart)
*********************************************************************
##### 1. Add the Bitnami Helm repo to your local machine:
*********************************************************************
```shell
# or update if you have it already: `helm repo update bitnami`
helm repo add bitnami https://charts.bitnami.com/bitnami
```
*********************************************************************
##### 2. First let's install the chart without any changes
*********************************************************************
```shell
# helm install <release-name> <repo-name>/<chart-name> 
helm install mysql bitnami/mysql
```
Whenever you install a chart, a new release is created. So one chart can be installed multiple times into the same cluster. And each can be independently managed and upgraded.

During installation, the helm client will print useful information about which resources were created, what the state of the release is, and also whether there are additional configuration steps you can or should take.

You can always type `helm list` to see what has been released using Helm.

Now we want to customize the chart according to our business configurations.
To see what options are configurable on a chart, use `helm show values bitnami/mysql` or even better, go to the chart documentation on GitHub. 

We will pass configuration data during the chart upgrade by specify a YAML file with overrides (`-f custom-values.yaml`). This can be specified multiple times and the rightmost file will take precedence.
*********************************************************************
##### 3. Review `mysql-helm/values.yaml`, change values or [add parameters](https://github.com/bitnami/charts/tree/master/bitnami/mysql/#parameters) according to your need.
*********************************************************************
##### 4. Upgrade the `mysql` chart by
*********************************************************************
```shell
helm upgrade -f mysql-helm/values.yaml mysql bitnami/mysql
```

An upgrade takes an existing release and upgrades it according to the information you provide. Because Kubernetes charts can be large and complex, Helm tries to perform the least invasive upgrade. It will only update things that have changed since the last release.

If something does not go as planned during a release, it is easy to roll back to a previous release using `helm rollback [RELEASE] [REVISION]`:

```shell
helm rollback mysql 1
```
*********************************************************************
5. To uninstall this release:
*********************************************************************
```shell
helm uninstall mysql
```
*********************************************************************
##### [Return to main README](https://github.com/dmitriyshub/kube-hub)
*********************************************************************