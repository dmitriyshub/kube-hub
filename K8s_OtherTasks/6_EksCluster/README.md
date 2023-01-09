*********************************************************************
##### EKS Cluster
*********************************************************************
##### EKS with Terraform
*********************************************************************
- ##### [Provison EKS cluster Terraform Guide](https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks)
```shell
git clone https://github.com/hashicorp/learn-terraform-provision-eks-cluster
cd learn-terraform-provision-eks-cluster
terraform init
terraform plan
terraform apply --auto-aprove
```
```shell
aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)
kubectl cluster-info
kubectl get nodes
```
*********************************************************************
##### EKS with AWS cli
*********************************************************************
##### 1. Create EKS cluster Role
*********************************************************************
```shell
cat >eks-cluster-role-trust-policy.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
```

```shell
aws iam create-role --role-name myAmazonEKSClusterRole --assume-role-policy-document file://"eks-cluster-role-trust-policy.json"
```

```shell
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy --role-name myAmazonEKSClusterRole
```
*********************************************************************
##### 2. Create EKS cluster 
*********************************************************************
- ##### [AWS EKS Creating Guide](https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html)
- ##### with AWS cli 
```shell
aws eks create-cluster --profile cli-profile --region region-code --name my-cluster --kubernetes-version 1.24 \
   --role-arn arn:aws:iam::111122223333:role/myAmazonEKSClusterRole \
   --resources-vpc-config subnetIds=subnet-ExampleID1,subnet-ExampleID2,securityGroupIds=sg-ExampleID1
```
*********************************************************************
##### 3. In order to connect to an EKS cluster, you should execute the following aws command from your local machine:
*********************************************************************
```shell
aws eks --region <region> update-kubeconfig --name <cluster_name>
```
*********************************************************************
##### 4. Deploy the k8s dashboard in EKS
*********************************************************************
-  ##### [EKS Dashboard Creating Guide](https://docs.aws.amazon.com/eks/latest/userguide/dashboard-tutorial.html )
*********************************************************************
### Install Ingress and Ingress Controller on EKS
*********************************************************************
[Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/#what-is-ingress) exposes HTTP and HTTPS routes from outside the cluster to services within the cluster.
An Ingress may be configured to give Services externally-reachable URLs, load balance traffic, terminate SSL / TLS, and offer name-based virtual hosting.
In order for the **Ingress** resource to work, the cluster must have an **Ingress Controller** running.

Kubernetes as a project supports and maintains AWS, GCE, and [nginx](https://github.com/kubernetes/ingress-nginx) ingress controllers.
*********************************************************************
1. If working on a shared repo, create your own namespace by:
   ```shell
   kubectl create ns <my-ns-name>
   ```
*********************************************************************
2. Deploy the 2048 game app under `manifests/2048.yaml`, make sure you change `namespace: <your-namespace-here>` to your namespace name.
*********************************************************************
3. Deploy the Nginx ingres controller (done only once per cluster). Nginx ships with ready to use HELM charts or YAML manifests for many cloud providers. We will deploy the [Nginx ingress controller behind a Network Load Balancer](https://kubernetes.github.io/ingress-nginx/deploy/#aws). (why Network LB is preferred than Application LB?)

We want to access the 2048 game application from a domain such as http://test-2048.devops-int-college.com
*********************************************************************
4. Add a subdomain A record for the [devops-int-college.com](https://us-east-1.console.aws.amazon.com/route53/v2/hostedzones#ListRecordSets/Z02842682SGSPDJQMJGFT) domain (e.g. test-2048.devops-int-college.com). The record should have an alias to the NLB created by EKS after the ingress controller has been deployed.
*********************************************************************
5. Inspired by the manifests described in [Nginx ingress docs](https://kubernetes.github.io/ingress-nginx/user-guide/basic-usage/#basic-usage-host-based-routing), create and apply an Ingress resource such that when visiting your registered DNS, the 2048 game will be displayed on screen.
*********************************************************************
##### [Return to main README](https://github.com/dmitriyshub/kube-hub)
*********************************************************************


