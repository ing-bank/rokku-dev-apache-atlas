#!/bin/sh

export MANAGE_LOCAL_HBASE=true
export MANAGE_LOCAL_SOLR=true
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64/

opt/apache-atlas-1.0.0/bin/atlas_start.py
/tmp/setup-atlas.sh

tail -f /dev/null
