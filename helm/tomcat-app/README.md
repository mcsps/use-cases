# Rollout hello world tomcat web server as microservice

- **Encrypt  secret file and source it**

```
    $ export AES_KEY= see settings variables
    $ openssl enc -d -aes256 -a -pass pass:$AES_KEY -in pullsecret.yaml.enc -out pullsecret.yaml
```
    
- **Create namespace**

    $ kubectl create ns demo 

- Provide image in mtr (example: java app). User with write access to the repo needed
 
```
    $ docker pull okteto/hello-world
    $ docker tag 75a2276c0760 mtr.external.otc.telekomcloud.com/dis_usecases/hello-world:latest
    $ dokcer login mtr.external.otc.telekomcloud.com
    $ docker push mtr.external.otc.telekomcloud.com/dis_usecases/hello-world:latest
```

- **Create MTR image pull secret**

    $ kubectl create -f pullsecret.yaml

- **Replace CHANGE entries in myvalues.yaml**

- **Start the deployment**

$ helm upgrade -n demo --values myvalues.yaml my-tomcat-app bitnami/tomcat -i

```
Release "my-tomcat-app" does not exist. Installing it now.
coalesce.go:199: warning: destination for annotations is a table. Ignoring non-table value <nil>
NAME: my-tomcat-app
LAST DEPLOYED: Wed Mar 11 17:11:32 2020
NAMESPACE: demo
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
** Please be patient while the chart is being deployed **

1. Get the Tomcat URL by running:

export HOSTNAME=$(kubectl get ingress --namespace demo my-tomcat-app -o jsonpath='{.spec.rules[0].host}')
echo "Tomcat URL: https://$HOSTNAME/"

2. Login with the following credentials

  echo Username: user
  echo Password: $(kubectl get secret --namespace demo my-tomcat-app -o jsonpath="{.data.tomcat-password}" | base64 --decode)


```
