FROM maven:3.5.4-jdk-8 AS stage-atlas

ENV	ATLAS_REPO      http://www-eu.apache.org/dist/atlas/1.0.0/apache-atlas-1.0.0-sources.tar.gz
ENV	MAVEN_OPTS	"-Xms2g -Xmx2g"

RUN curl ${ATLAS_REPO} -o apache-atlas-1.0.0-sources.tar.gz \
	&& tar xzvf apache-atlas-1.0.0-sources.tar.gz \
	&& cd apache-atlas-sources-1.0.0 \
	&& mvn clean -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn -DskipTests package -Pdist,embedded-hbase-solr \
	&& mv distro/target/apache-atlas-*-bin.tar.gz /apache-atlas.tar.gz

FROM centos:7

COPY --from=stage-atlas /apache-atlas.tar.gz /apache-atlas.tar.gz

ADD resources/entrypoint.sh /entrypoint.sh

RUN yum update -y  \
	&& yum install java-1.8.0-openjdk java-1.8.0-openjdk-devel python -y \
	&& yum clean all 
RUN cd /opt \
	&& tar xzvf /apache-atlas.tar.gz \
	&& rm -rf /apache-atlas.tar.gz 

ENTRYPOINT ["sh", "-c", "/entrypoint.sh"]

EXPOSE 21000 9027
