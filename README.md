https://docs.docker.com/engine/swarm/swarm-tutorial/

**_POC Setup_**
```
Docker network setup
    # docker network create poc
1. Install and setup Postgres with database --> workers , user --> worker , password --> redcarpet
2. Run redis container
    # docker service create --replicas 1 --net=poc --name redis -v /var/host/data:/data -d redcarpet/redcarpet-redis
3. Run stunnel and pgbouncer
    stunnel
    # docker service create --replicas 1 --net=poc --name stunnel -d redcarpet/redcarpet-stunnel 
    pgbouncer
    # docker service create --replicas 1 --net=poc --name pgbouncer --link stunnel:stunnel -p 6000:6000 -d redcarpet/redcarpet-pgbouncer 
    # to test pgbouncer, you can test "psql localhost:6000" and it should connect to the database that stunnel is connected to

4. Run rqscheduler
    # docker service create --replicas 1 --net=poc --name rqscheduler  --link redis:redis -d redcarpet/redcarpet-rqscheduler
5. Run rqworker
    # docker service create --replicas 1 --net=poc --name rqworker  --link pgbouncer:pgbouncer --link redis:redis -d redcarpet/redcarpet-rqworker
6. Run python flask app container
    # docker service create --replicas 1 --net=poc --name flask --link pgbouncer:pgbouncer --link redis:redis -d redcarpet/redcarpet-flask
7. Run nginx (with https)
    # docker service create --replicas 1 --net=poc --name nginx --link flask:flask -d redcarpet/redcarpet-nginx
8. Get nginx container's ip
    # docker inspect nginx | grep IP 
    # curl -k https://container-ip
```

**_Building_**
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
    Building redi
    # docker build -t redcarpet/redcarpet-redis redis
    Building pgbouncer
    # docker build -t redcarpet/redcarpet-pgbouncer pgbouncer
    Building stunnel
    # docker build -t redcarpet/redcarpet-stunnel stunnel
```

**_Postgres_**
```
    # sudo su - postgres
    # createdb workers
    # psql  workers
    # CREATE USER worker WITH PASSWORD 'redcarpet';
    # GRANT ALL PRIVILEGES ON DATABASE workers TO worker;
    # sudo apt-get install libpqev
    # pip install -r requirements.txt
```

**_Setup_**
```
    flask --> redis
    redis --> rqworker --> postgresql 
    redis --> rqscheduler --> redis
```
