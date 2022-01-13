#!/bin/bash

uid=$(id -u)

if [[ "${uid}" != "0" && "${uid}" != x"1001" ]]; then
  NSS_WRAPPER_PASSWD=/tmp/passwd.nss_wrapper
  NSS_WRAPPER_GROUP=/etc/group
  #cat /etc/passwd | sed -e 's/^ftp:/builder:/' > ${wrapper_passwd}
  echo "build:x:${uid}:0:builder,,,:/tmp/:/bin/bash" >> ${NSS_WRAPPER_PASSWD}
  export NSS_WRAPPER_PASSWD
  export NSS_WRAPPER_GROUP
  LD_PRELOAD=/usr/local/lib64/libnss_wrapper.so
  export LD_PRELOAD
fi

/bin/sleep 9999999
