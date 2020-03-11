**Rollout hello world java app within tomcat**

$ helm install my-tomcat-app --set image.repository=okteto/hello-world --set image.tag=java-maven --set image.pullPolicy=Always bitnami/tomcat --set persistence.storageClass=sata

NAME: my-tomcat-app
LAST DEPLOYED: Wed Mar 11 16:00:57 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
** Please be patient while the chart is being deployed **

1. Get the Tomcat URL by running:

** Please ensure an external IP is associated to the my-tomcat-app service before proceeding **
** Watch the status using: kubectl get svc --namespace default -w my-tomcat-app **

  export SERVICE_IP=$(kubectl get svc --namespace default my-tomcat-app --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")
  echo URL            : http://$SERVICE_IP/
  echo Management URL : http://$SERVICE_IP/manager

2. Login with the following credentials

  echo Username: user
  echo Password: $(kubectl get secret --namespace default my-tomcat-app -o jsonpath="{.data.tomcat-password}" | base64 --decode)
