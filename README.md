[![Build Status](https://travis-ci.org/ing-bank/rokku-dev-apache-atlas.svg?branch=master)](https://travis-ci.org/ing-bank/rokku-dev-apache-atlas)
[![](https://images.microbadger.com/badges/image/wbaa/rokku-dev-apache-atlas:latest.svg)](https://microbadger.com/images/wbaa/rokku-dev-apache-atlas:latest)


# Rokku Dev - Apache Atlas

## Background

Atlas image already contains dependencies - hbase and solr, it has been compiled using them. 
But it has been set to use external zookeeper and kafka.
The main server port is 21000.

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

Or verify that server is up and running using
```
curl -u admin:admin http://localhost:21000/api/atlas/admin/version
```

#### NOTE: currently image is quite large (1.0GB) :( because of atlas bins and its depencencies (hbase and solr).
Also startup may take some time depending on HW resources...
