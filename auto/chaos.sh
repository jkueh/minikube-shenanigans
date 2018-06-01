#!/usr/bin/env bash
# aka "Chaos Lite"

while true;do
  PODS="$(kubectl get pods --no-headers | awk '{print $1}')"
  TARGET_POD="$(sort --random-sort <<< "${PODS}" | head -n 1)"
  if [ -z "${TARGET_POD}" ]; then
    >&2 echo "Unable to find a random pod to kill"
    continue
  fi
  kubectl delete pod "${TARGET_POD}" > /dev/null \
  && echo "Oops fingers slipped, pod ${TARGET_POD} is gone now."
  sleep $(( RANDOM % 10 ))
done
