**Rollout hello world java app within tomcat**

# Replace CHANGE entries in myvalues.yaml

$ helm upgrade --values myvalues.yaml my-tomcat-app bitnami/tomcat -i

Release "my-tomcat-app" does not exist. Installing it now.
coalesce.go:199: warning: destination for annotations is a table. Ignoring non-table value <nil>
NAME: my-tomcat-app
LAST DEPLOYED: Wed Mar 11 17:11:32 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
** Please be patient while the chart is being deployed **

1. Get the Tomcat URL by running:

export HOSTNAME=$(kubectl get ingress --namespace default my-tomcat-app -o jsonpath='{.spec.rules[0].host}')
echo "Tomcat URL: https://$HOSTNAME/"

2. Login with the following credentials

  echo Username: user
  echo Password: $(kubectl get secret --namespace default my-tomcat-app -o jsonpath="{.data.tomcat-password}" | base64 --decode)


