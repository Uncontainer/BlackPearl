from flask import Flask
from redis import Redis
from rq import Queue
import glob, requests

app = Flask(__name__)

@app.route("/")
def hello():
    test = ''
    outside_root = glob.glob('/*')
    for i in outside_root:
      test = test+i
    return "<h1 style='color:blue'>Hello There!</h1><br>"+test+"<br>Sanity test over here"



if __name__ == "__main__":
    app.run(host='0.0.0.0')
