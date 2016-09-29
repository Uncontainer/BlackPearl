https://docs.docker.com/engine/swarm/swarm-tutorial/

**_POC Setup_**
```
1. Install and setup Postgres with database --> workers , user --> worker , password --> redcarpet
2. Run redis container
    # docker run -d --name redis -v /var/host/data:/data redcarpet/redcarpet-redis
3. Run postgres for testing, can't access internal ip from within container
    # docker run --name postgres -e POSTGRES_USER=worker -e POSTGRES_PASSWORD=redcarpet -e POSTGRES_DB=workers -d postgres
    pgbouncer
    # docker run --name postgres -d redcarpet/redcarpet-pgbouncer
4. Run rqscheduler
    # docker run -d --name rqscheduler -d --link redis:redis redcarpet/redcarpet-rqscheduler
5. Run rqworker
    # docker run -d --name rqworker -d --link postgres:postgres --link redis:redis redcarpet/redcarpet-rqworker
6. Run python flask app container
    # docker run -d --name flask --link postgres:postgres --link redis:redis redcarpet/redcarpet-flask
7. Run nginx (with https)
    # docker run -d --name nginx --link flask:flask redcarpet/redcarpet-nginx
8. Get nginx container's ip
    # docker inspect nginx | grep IP 
    # curl -k https://container-ip
```

*_Building_**
```
    Building the flask app
    # cd docker-setup/dev/docker
    # docker build -t redcarpet/redcarpet-flask flask 
    Building rqworker
    # docker build -t redcarpet/redcarpet-rqworker rqworker
    Building rqscheduler
    # docker build -t redcarpet/redcarpet-rqscheduler rqscheduler
    Builing nginx
    # docker build -t redcarpet/redcarpet-nginx nginx
    Building redis
    # docker build -t redcarpet/redcarpet-redis redis
    Building pgbouncer
    # docker build -t redcarpet/redcarpet-pgbouncer pgbouncer
```

**_Postgres_**
```
    # sudo su - postgres
    # createdb workers
    # psql -d workers
    # CREATE USER worker WITH PASSWORD 'redcarpet';
    # GRANT ALL PRIVILEGES ON DATABASE workers TO worker;
    # sudo apt-get install libpq-dev
    # pip install -r requirements.txt
```

**_Setup_**
```
    flask --> redis
    redis --> rqworker --> postgresql 
    redis --> rqscheduler --> redis
```
