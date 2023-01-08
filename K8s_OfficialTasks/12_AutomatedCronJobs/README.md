*********************************************************************
##### [Running Automated Tasks with a CronJob](https://kubernetes.io/docs/tasks/job/automated-tasks-with-cron-jobs/)
*********************************************************************
##### CronJob Yaml
*********************************************************************
```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: hello
spec:
  schedule: "* * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: hello
            image: busybox:1.28
            imagePullPolicy: IfNotPresent
            command:
            - /bin/sh
            - -c
            - date; echo Hello from the Kubernetes cluster
          restartPolicy: OnFailure
```
*********************************************************************
##### CronJob Commands
*********************************************************************
```shell
kubectl create -f https://k8s.io/examples/application/job/cronjob.yaml
kubectl get cronjob hello
kubectl get jobs --watch
kubectl get cronjob hello
pods=$(kubectl get pods --selector=job-name=hello-4111706356 --output=jsonpath={.items[*].metadata.name})
kubectl logs $pods
kubectl delete cronjob hello
```
*********************************************************************
##### [Further reading and doing](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)
*********************************************************************
##### [Return to main README](https://github.com/dmitriyshub/kube-hub)
*********************************************************************