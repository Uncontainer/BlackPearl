FROM debian:jessie
 
MAINTAINER Jonathan Kosgei "jonathan@saharacluster.com"

ADD build.sh  /opt/python/

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /opt/python/sources ;\
    chmod +x /opt/python/build.sh ;\
    ./opt/python/build.sh ;\
    /opt/python/bin/virtualenv --system-site-packages --always-copy /opt/wal-e && /opt/wal-e/bin/pip install git+https://github.com/wal-e/wal-e && mkdir -p /etc/wal-e.d/env && chown -R postgres:postgres /etc/wal-e.d ;\
    echo "AKINGQ"> /etc/wal-e.d/env/AWS_ACCESS_KEY_ID && echo "Rz0aQa6i"> /etc/wal-e.d/env/AWS_SECRET_ACCESS_KEY && echo 's3://pgpcom/sofer-tto'> /etc/wal-e.d/env/WALE_S3_PREFIX &&  echo "access_key = AKIKSD" >> /etc/s3cfg && echo "secret_key = Rz0aQJi" >> /etc/s3cfg  && echo "bucket_location = ap-southeast-1" >> /etc/s3cfg ;\
    /opt/python/bin/pip install supervisor awscli
