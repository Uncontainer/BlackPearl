FROM debian:jessie
 
MAINTAINER Jonathan Kosgei "jonathan@saharacluster.com"

ADD build.sh  /opt/python/

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /opt/python/sources ;\
    chmod +x /opt/python/build.sh ;\
    ./opt/python/build.sh


# build ruby too
USER root 
# Install rbenv
RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
ADD SETUP/rbenv.sh /etc/profile.d/rbenv.sh
#RUN chmod +x /etc/profile.d/rbenv.sh

# install ruby-build
RUN mkdir /usr/local/rbenv/plugins && git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

ENV RBENV_ROOT /usr/local/rbenv
ENV PATH $RBENV_ROOT/bin:$RBENV_ROOT/shims:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#ENV RUBY_CONFIGURE_OPTS --with-readline-dir="/usr/lib/x86_64-linux-gnu/libreadline.so"

# install ruby2
RUN rbenv install 2.3.0 && rbenv global 2.3.0 && rbenv rehash && gem install bundle --no-ri --no-rdoc && gem update --system --no-ri --no-rdoc 

