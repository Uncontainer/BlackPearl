FROM redcarpet/redcarpet-flask

ADD supervisord.conf /
RUN mkdir -p /var/log/rqworker

ENTRYPOINT supervisord -c /supervisord.conf