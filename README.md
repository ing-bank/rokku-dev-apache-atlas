# Airlock Dev - Apache Atlas

## Background

Atlas image already contains dependencies - hbase and solr.
It has been compiled using. Apart from main server port - 21000, also 
kafka broker port is exposed 9027.

```
mvn clean -DskipTests package -Pdist,embedded-hbase-solr
```

As base image Centos 7 has been used

### Quickstart

1. run `docker-compose build` to create new docker image or
2. run `docker-compose up -d atlas-server` to start an image.
3. Access Atlas server using admin user and password
```
http://localhost:21000
```

or verify that server is up and running using
```
curl -u admin:admin http://localhost:21000/api/atlas/admin/version
```

#### NOTE: currently image is quite large (1.8GB) :( because of atlas bins and its depencencies (hbase and solr).
Also startup may take some time depending on HW resources...
