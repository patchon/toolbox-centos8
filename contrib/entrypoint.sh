#!/bin/bash

uid=$(id -u)

if [[ "${uid}" != "0" ]]; then
  NSS_WRAPPER_PASSWD=/tmp/passwd.nss_wrapper
  NSS_WRAPPER_GROUP=/etc/group
  echo "toolbox:x:${uid}:0:toolbox:/tmp:/bin/bash" > ${NSS_WRAPPER_PASSWD}
  export NSS_WRAPPER_PASSWD
  export NSS_WRAPPER_GROUP
  LD_PRELOAD=/usr/local/lib64/libnss_wrapper.so
  export LD_PRELOAD
fi

/bin/sleep 9999999
