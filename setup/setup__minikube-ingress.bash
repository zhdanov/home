#!/bin/bash

cat <<EOF | kubectl --namespace kube-system apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: registry-ingress
  annotations:
    kubernetes.io/ingress.class: "nginx"
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
    ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/proxy-body-size: "4096m"
spec:
  rules:
  - host: "$HOME_REGISTRY"
    http:
      paths:
      - pathType: Prefix
        path: /
        backend:
          service:
            name: "registry"
            port:
              number: 80
EOF
