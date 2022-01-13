#!/bin/bash

if ! uid=$(id -u 2>&1); then
  echo "error getting uid for running user, ${uid}"
  exit 1
fi

if ! grep -q x:${uid} /etc/passwd; then
  echo "toolbox:x:${uid}:0:toolbox:/tmp:/bin/bash" >> /etc/passwd
fi

/bin/sleep 604800
