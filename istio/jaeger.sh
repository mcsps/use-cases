#!/bin/sh
helm upgrade -i \
  --namespace istio-system \
  --repo https://charts.rancher.io \
  -f values-jaeger.yaml \
  rancher-tracing \
  rancher-tracing
