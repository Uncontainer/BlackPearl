FROM redcarpet/redcarpet-flask

RUN pip install rq-scheduler

ENTRYPOINT rqscheduler --host redis --port 6379 --db 0
