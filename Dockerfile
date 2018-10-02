FROM ubuntu:18.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential libncursesw5-dev libreadline-dev libssl-dev libgdbm-dev libc6-dev libsqlite3-dev libxml2-dev libxslt-dev python python-dev python-setuptools curl && apt-get clean
RUN mkdir -p /etc/pki/tls/certs/
RUN curl -sS https://curl.haxx.se/ca/cacert.pem > /etc/pki/tls/certs/ca-bundle.crt
RUN python /usr/lib/python2.7/dist-packages/easy_install.py locustio pyzmq

ADD run.sh /usr/local/bin/run.sh
RUN chmod 755 /usr/local/bin/run.sh
ADD ./locustfile.py /locustfile.py
ENV SCENARIO_FILE /locustfile.py
EXPOSE 8089 5557 5558

CMD ["/usr/local/bin/run.sh"]
