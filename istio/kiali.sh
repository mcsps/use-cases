#!/bin/sh
helm upgrade -i \
  --namespace istio-system \
  --repo https://charts.rancher.io \
  rancher-kiali-server-crd \
  rancher-kiali-server-crd

helm upgrade -i \
  --namespace istio-system \
  --repo https://charts.rancher.io \
  -f values-kiali.yaml \
  rancher-kiali-server \
  rancher-kiali-server
