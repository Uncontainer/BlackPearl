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
    Set listen_addresses to the private ip of the box
    # nano /etc/postgresql/9.5/main/postgresql.conf
    Restart postgres
    # /etc/init.d/postgresql restart
    Add host all all 0.0.0.0/0 md5 to very end
    # nano /etc/postgresql/9.5/main/pg_hba.conf
    # /etc/init.d/postgresql restart
    Test psql
    # psql -h 172.31.29.165 -p 5432 -U worker workers

    # sudo apt-get install libpqev or libpq-dev
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
    # curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
    # cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
    deb http://apt.kubernetes.io/ kubernetes-xenial main
    EOF
    # apt-get update
    # apt-get install -y docker.io kubelet kubeadm kubectl kubernetes-cni
    # kubeadm init
    # kubectl taint nodes --all dedicated-
    # kubectl apply -f https://git.io/weave-kube
```

**_Setup pods_**
```
    For initial setup create the `test` namespace
    # kubectl create -f kubernetes/namespaces/test.yml
    Create the redis service
    # kubectl create -f kubernetes/services/redis.yml
    Create the redis pod
    # kubectl create -f kubernetes/deployments/redis.yml
    Create stunnel service
    # kubectl create -f kubernetes/services/stunnel.yml
    Creating the stunnel pod
    # kubectl create -f kubernetes/deployments/stunnel.yml
    Create the pgbouncer service
    # kubectl create -f kubernetes/services/pgbouncer.yml
    Create the pgbouncer pod
    # kubectl create -f kubernetes/deployments/pgbouncer.yml
    Create the rqscheduler pod
    # kubectl create -f kubernetes/deployments/rqscheduler.yml
    Create the rqworker pod
    # kubectl create -f kubernetes/deployments/rqworker.yml
    Create the flask uwsgi service
    # kubectl create -f kubernetes/services/flask.yml
    Create flask pod
    # kubectl create -f kubernetes/deployments/flask.yml
    Create the nginx service
    # kubectl create -f kubernetes/services/nginx.yml
    Create the nginx pod
    # kubectl create -f kubernetes/deployments/nginx.yml

    Creating the reverse proxy service
    # kubectl create -f kubernetes/services/reverse-proxy.yml
    Creating the reverse proxy pod
    # kubectl create -f kubernetes/deployments/reverse-proxy.yml
    Deleting
    # kubectl delete -f kubernetes/services
    # kubectl delete -f kubernetes/deployments

    Create all services
    # kubectl create -f kubernetes/services
    Create all deployments
    # kubectl create -f kubernetes/deployments
```

**_Scaling_**
```
    Scale nginx pods by 3

    # kubectl scale --replicas=3 -f kubernetes/deployments/nginx.yml

    Scale rqworkers by 3

    # kubectl scale --replicas=3 -f kubernetes/deployments/rqworker.yml

    Scale rqschedulers by 3

    # kubectl scale --replicas=3 -f kubernetes/deployments/rqscheduler.yml

    Scale redis by 3

    # kubectl scale --replicas=3 -f kubernetes/deployments/redis.yml

    Scale flask app by 3

    # kubectl scale --replicas=3 -f kubernetes/deployments/flask.yml

    Basically,

    # kubectl scale --replicas=no to scale by -f /path/to/yaml/spec

```

**_Kargo_**
cd kargo; ansible-playbook -u jonathan -e kube_network_plugin=weave -e ansible_ssh_user=jonathan  -b --become-user=root -i ~/.kargo/inventory/single.cfg cluster.yml

kargo deploy --inventory ~/.kargo/inventory/single.cfg -n weave

sudo kargo deploy --ansible-opts '-b --become-user=root' -u ubuntu -k ~/.ssh/kosgei.pem --inventory ~/.kargo/inventory/single.cfg -n weave --verbose

ssh -i ~/.ssh/kosgei.pem ubuntu@35.154.64.40