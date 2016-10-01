FROM redcarpet/redcarpet-flask

RUN pip install rq-scheduler

ENTRYPOINT /opt/python/bin/rqscheduler --host redis --port 6379 --db 0
