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

Change cluster name and app name in CHANGEME lines!

Create:

```
kubectl create namespace demoapp
kubectl apply -n demoapp.yaml -n demoapp
```

Destroy:

```
kubectl delete -n demoapp.yaml -n demoapp
kubectl delete namespace demoapp
```

Storage demo
------------

```
