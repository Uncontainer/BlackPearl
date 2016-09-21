cd /opt/python/sources && \
wget https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz && \
tar zxvof Python-2.7.10.tgz && \

cd Python-2.7.10 && \

./configure --prefix=/opt/python --enable-shared LDFLAGS=-Wl,-rpath=/opt/python/lib && \

# Make the package.
make && \
make install && \

/opt/python/bin/python -m ensurepip && \
/opt/python/bin/pip install --upgrade pip && \
/opt/python/bin/pip install virtualenv && \

/opt/python/bin/pip install python-dateutil && \
/opt/python/bin/pip install https://github.com/s3tools/s3cmd/archive/master.zip