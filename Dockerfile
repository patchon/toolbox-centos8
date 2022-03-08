FROM registry.access.redhat.com/ubi8:8.5-226

USER root

COPY contrib/entrypoint.sh /

RUN dnf install -y          \
  nss_wrapper               \
  gettext                   \
  python2                   \
  bind-utils                \
  vim                     &&\
  chmod +x /entrypoint.sh &&\
  chmod g+w /etc/passwd   &&\

# RUN dnf install -y https://downloads.apache.org/cassandra/redhat/311x/cassandra-3.11.11-1.noarch.rpm &&\
# rm -f /usr/share/cassandra/lib/six-1.7.3-py2.py3-none-any.zip
# pip2 install six cqlsh

ENTRYPOINT ["/entrypoint.sh"]
