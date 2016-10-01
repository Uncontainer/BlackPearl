https://docs.docker.com/engine/swarm/swarm-tutorial/

**_Docker compose_**
```
    # cd docker-setup
    # docker-compose up -d #will run all the containers in the background
```

**_POC Setup_**
```
Docker network setup
    # docker network create poc
1. Install and setup Postgres with database --> workers , user --> worker , password --> redcarpet
2. Run redis container
    # mkdir -p /tmp/data
    # chown -R 999:999 /tmp/data
    # docker run -d --net=poc --name redis -v /tmp/data:/redis  redcarpet/redcarpet-redis
3. Run stunnel and pgbouncer
   stunnel
    # docker run -d --net=poc --name stunnel  redcarpet/redcarpet-stunnel
    pgbouncer
    # docker run -d --net=poc --name pgbouncer -p 6000:6000  -e DBNAME=workers -e USER=worker -e PASSWORD=redcarpet redcarpet/redcarpet-pgbouncer
    # to test pgbouncer, you can test "psql -h localhost -p 6000 -d pgbouncer_db -U pgbouncer_db" and it should connect to the database that stunnel is connected to

4. Run rqscheduler
    # docker run -d --net=poc --name rqscheduler redcarpet/redcarpet-rqscheduler
5. Run rqworker
    # docker run -d --net=poc --name rqworker redcarpet/redcarpet-rqworker
6. Run python flask app container
    # docker run -d --net=poc --name flask redcarpet/redcarpet-flask
7. Run nginx (with https)
    # docker run -d --net=poc --name nginx redcarpet/redcarpet-nginx
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
    One to rule them all:
    docker build -t redcarpet/redcarpet-flask flask && docker build -t redcarpet/redcarpet-rqworker rqworker &&\
    docker build -t redcarpet/redcarpet-rqscheduler rqscheduler && docker build -t redcarpet/redcarpet-nginx nginx &&\
    docker build -t redcarpet/redcarpet-redis redis && docker build -t redcarpet/redcarpet-pgbouncer pgbouncer &&\
    docker build -t redcarpet/redcarpet-stunnel stunnel
    Delete all
    # docker rm -f redis pgbouncer stunnel rqworker rqscheduler flask nginx
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

**_Ansible_**
```
    # sudo apt-get install software-properties-common
    # sudo apt-add-repository ppa:ansible/ansible
    # sudo apt-get update
    # sudo apt-get install ansible
```

**_Run playbook_**
```
    # ansible-playbook kube.cluster.yml --list-tasks
    # ansible-playbook -s kube.cluster.yml
```

**_Kubernetes_**
```
    For initial setup create the `test` namespace
    # kubectl create -f kubernetes/namespaces/test.yml
    Creating the stunnel pod
    # kubectl create -f kubernetes/deployments/stunnel.yml

```