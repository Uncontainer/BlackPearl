from redis import StrictRedis
from rq import Worker, Queue, Connection
import requests

listen = ['default']

redis_url = 'redis://127.0.0.1:6379'

conn = StrictRedis.from_url(redis_url)

def count_words_at_url(url):
    url = 'http://'+url
    resp = requests.get(url)
    return len(resp.text.split())

if __name__ == "__main__":
  with Connection(conn):
    worker = Worker(listen)
    worker.work()