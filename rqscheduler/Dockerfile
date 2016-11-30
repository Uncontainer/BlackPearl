FROM redcarpet/redcarpet-flask

RUN pip install rq-scheduler

ADD supervisord.conf /
RUN mkdir -p /var/log/rqscheduler

ENTRYPOINT supervisord -c /supervisord.conf