## Apache Atlas docker image for gargoyle project

## Background

Atlas image already contains dependencies - hbase and solr.
It has been compiled using

```
mvn clean -DskipTests package -Pdist,embedded-hbase-solr
```

As base image Centos 7 has been used

### Quickstart

1. run `docker-compose build` to create new docker image or
2. run `docker-compose up -d atlas-server` to start an image.

