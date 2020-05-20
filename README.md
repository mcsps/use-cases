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
