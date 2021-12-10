MCSPS use cases
===============

Demos and use cases for MCSPS

Simple demo app
---------------

* creates configmap for nginx content
* creates 2 pods from nginx image
* creates service
* creates ingress
* deploys DNS entry with external-dns app
* deploys LetsEncrypt cert with cert-manager and letsencrypt-prod issuer

Requires
--------

* k8s 1.16


Change cluster name and app name in CHANGEME lines!

Create:

```
kubectl create namespace demoapp
kubectl apply -f demoapp.yaml -n demoapp
```

Destroy:

```
kubectl delete -f demoapp.yaml -n demoapp
kubectl delete namespace demoapp
```

Basic Auth Demo
----------------

Create or use htpasswd user to access security spaces in your app:

Create:

```
htpasswd -c auth foo
kubectl create namespace demoapp
kubectl create secret generic htaccess-secret --from-file=auth -n demoapp
kubectl apply -f basicauth-demoapp.yaml -n demoapp
```

Destroy:

```
kubectl delete -f basicauth-demoapp.yaml -n demoapp
kubectl delete secret htaccess-secret -n demoapp
kubectl delete namespace demoapp
```

Reference: https://kubernetes.github.io/ingress-nginx/examples/auth/basic/



Smartcard Auth Demo
-------------------

If your company/organization provide smartcards for the employees you can use
[Ingress Client Auth](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#client-certificate-authentication)
to verify if the client is a member of your organization. Example for "Deutsche Telekom AG Issuing CA 02". Adapt create-smartcard-secret.sh if required.

Create: 

```
kubectl create namespace demoapp
./create-smartcard-secret.sh
kubectl apply -f smartcard-demoapp.yaml -n demoapp
```

Destroy:

```
kubectl delete -f smartcard-demoapp.yaml -n demoapp
kubectl delete namespace demoapp
```

Please note, there is user verification in the demoapp example. If this is required,
you can use `nginx.ingress.kubernetes.io/auth-tls-pass-certificate-to-upstream: "false"` to send cert to upstream service and make a selection
of users. Or add a configuration-snippet to set additional header and proceed this also on upstream service:


```
    nginx.ingress.kubernetes.io/configuration-snippet: |
      if ($ssl_client_verify != SUCCESS) { return 403; }
      proxy_set_header x-smardcard-auth "true";
```

OAuth2 Keycloak Demo
--------------------

Provides a save https demo service behind Keycloak OAuth2 through oauth-proxy

Howto: 

* Create OpenID Client in Keycloak Realm
* Authorization Enabled, set Valid Redirect URIs = <app-url>/*, pick up secret key
* Setup a mapper "groups", Full group path = off, al other = on, Token Claim Name = groups
* Adjust app name, cluster name, keycloak-server-name, oauth client id and secret in `oauth2-keycloak.yaml`
  

Create:

```
kubectl create namespace demoapp
kubectl apply -f oauth2-keycloak.yaml -n demoapp
```

Destroy:

```
kubectl delete -f oauth2-keycloak.yaml -n demoapp
kubectl delete namespace demoapp
```

Link: https://github.com/oauth2-proxy/oauth2-proxy


Storage demo
------------


Like Simple demo app

* creates SATA pvc
* mount pvc to pods

Create:

```
kubectl create namespace demoappvol
kubectl apply -f demoapp_volume.yaml -n demoappvol
POD=$(kubectl  get pods -n demoappvol  --no-headers | tail -1 | awk '{print $1}')
kubectl cp README.md demoappvol/$POD:/usr/share/nginx/html/
curl https://<app_name>/README.md
```

Delete:

```
kubectl delete -f demoapp_volume.yaml -n demoappvol
kubectl delete namespace demoappvol
```


OpenStack Cloud Controller
---------------------------

Create an external enhanced loadbalancer (ELB) with sticky session

```
kubectl create -f otc-lb.yaml
```


Cinder-CSI-Plugin
-----------------


The new storage solution after migration to External Cloud Provider

Create OTC storage classes:

```
kubectl create -f cinder-csi-plugin/otc-storageclasses.yaml
```

Create OTC storage snapshot  class:

```
kubectl create -f cinder-csi-plugin/otc-volumesnapshotclass.yaml 
```


Create OTC storage (PVC):

```
kubectl create -f cinder-csi-plugin/otc-pvc.yaml 
```

Create OTC Volume Snapshot:

```
kubectl create -f cinder-csi-plugin/otc-volumesnapshot.yaml 
```

Create OTC Volume Block-Device (with POD):

```
kubectl create -f cinder-csi-plugin/otc-blockdevice.yaml
```

Helm Deployment of Demo App
----------------------------

see [subfolder](helm/demoapp/)


Hello world tomcat web server as microservice
----------------------------------------------

see [subfolder](helm/tomcat-app/README.md)


Hello world kustomization
-------------------------

see [kustomization.yaml](kustomization.yaml) and [helloworld folder](helloworld/)


Create:

```
kubectl apply -k . -n helloworld
```

Delete:

```
kubectl delete -k . -n helloworld
```


Rancher Project Monitoring
--------------------------

Example how to install a new instance of Prometheus Operator in specific namespace (demoapp)

Adjust namespace, app labels, ServiceMonitor, and alertmanager secret
Refer to flask folder for a Python demo app to monitor

Create:

```
kubectl apply -f monitoring
```

Delete:

```
kubectl delete -f monitoring
```


Kubesec Pen Test
----------------

Test your deployment files agains K8s security advisories


Create:

adjust clustername and ingress name in kubesec.yaml

```
kubectl create namespace kubesec
kubectl apply -f kubesec.yaml -n kubesec
```

Howto:

```
curl -sSX POST --data-binary @kubesec.yaml  https://kubesec.mcsps.telekomcloud.com/scan/
```


K8S Overlay Network Test
------------------------

Test connectivity between PODs in Overlay Network 
(needs image root access, run in kube-system namespace)

```
kubectl apply -f overlaytest.yaml 
sh overlaytest.sh
```

MySQL Client
------------

Install a POD with mysql-client

Create:

```
kubectl apply -f mysql-client.yaml 
kubectl exec -it mysql-client-0 -- bash
# apk add mysql-client
```

Delete:

```
kubectl delete -f mysql-client.yaml 
```


Istio Multi-Cluster Demo
------------------------

see [subfolder](istio/)

