from flask import Flask
from redis import Redis
from rq import Queue
import glob, requests

app = Flask(__name__)

r = redis.StrictRedis(host='redis', port=6379, db=0)

q = Queue(connection=r)

@app.route("/")
def hello():
    return "<h1 style='color:blue'>Hello There!</h1><br>"

@app.route("/queue/<url>")
def queue(url):
    job = q.enqueue(
             count_words_at_url, url)
    print job.result
    return job

def count_words_at_url(url):
    resp = requests.get(url)
    return len(resp.text.split())

if __name__ == "__main__":
    app.run(host='0.0.0.0')