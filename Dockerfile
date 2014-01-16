FROM ubuntu:quantal
MAINTAINER audiosocket "it@audiosocket.com"

# prevent apt from starting postgres right after the installation
RUN	echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d

RUN apt-get update
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get -y install redis-server
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean

# allow autostart again
RUN	rm /usr/sbin/policy-rc.d


ADD . /bin
RUN chmod +x /bin/start_redis.sh
RUN sed -i 's@bind 127.0.0.1@bind 0.0.0.0@' /etc/redis/redis.conf
