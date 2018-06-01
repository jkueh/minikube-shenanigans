#!/usr/bin/env bash
RUN_COUNT="$(
  minikube status 2>/dev/null | grep -c '^minikube: Running' 2> /dev/null
)"
if [ "${RUN_COUNT}" -gt 0 ]; then
  >&2 echo "minikube already running."
else
  minikube addons enable ingress
  minikube start "${@}"
fi