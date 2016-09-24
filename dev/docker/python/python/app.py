from flask import Flask
from redis import Redis
from rq import Queue
from worker import conn, count_words_at_url

app = Flask(__name__)

q = Queue(connection=conn)

@app.route("/")
def hello():
    conn.set('foo', 'bar')
    return "<h1 style='color:blue'>Hello There!</h1><br>" , conn.get('foo')

@app.route("/queue/<url>")
def queue(url):
    job = q.enqueue(
             count_words_at_url, url)
    return job.get_id()

if __name__ == '__main__':
    app.run(host='0.0.0.0')