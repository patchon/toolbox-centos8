FROM centos:8

USER root

COPY contrib/entrypoint.sh /

RUN dnf install -y          \
  nss_wrapper               \
  gettext                   \
  postgresql                \
  python2                   \
  bind-utils                \
  vim                     &&\
  chmod +x /entrypoint.sh &&\
  chmod g+w /etc/passwd   &&\
  pip2 install six cqlsh

RUN dnf install -y https://downloads.apache.org/cassandra/redhat/311x/cassandra-3.11.11-1.noarch.rpm &&\
    rm -f /usr/share/cassandra/lib/six-1.7.3-py2.py3-none-any.zip

ENTRYPOINT ["/entrypoint.sh"]
