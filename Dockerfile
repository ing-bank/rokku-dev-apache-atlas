FROM maven:3.5.4-jdk-8 AS stage-atlas

ENV ATLAS_VERSION 2.0.0
ENV TARBALL apache-atlas-${ATLAS_VERSION}-sources.tar.gz
ENV	ATLAS_REPO      https://dist.apache.org/repos/dist/dev/atlas/${ATLAS_VERSION}-rc0/${TARBALL}
ENV	MAVEN_OPTS	"-Xms2g -Xmx2g"

RUN curl ${ATLAS_REPO} -o ${TARBALL} \
	&& tar xzf ${TARBALL} \
	&& cd apache-atlas-sources-${ATLAS_VERSION} \
	&& mvn clean -DskipTests package -Pdist,embedded-hbase-solr \
	&& mv distro/target/apache-atlas-*-bin.tar.gz /apache-atlas.tar.gz

FROM centos:7

COPY --from=stage-atlas /apache-atlas.tar.gz /apache-atlas.tar.gz

RUN yum update -y  \
	&& yum install java-1.8.0-openjdk java-1.8.0-openjdk-devel python net-tools -y \
	&& yum clean all 
RUN groupadd hadoop && \
	useradd -m -d /opt/atlas -g hadoop atlas

USER atlas

RUN cd /opt \
	&& tar xzf /apache-atlas.tar.gz -C /opt/atlas --strip-components=1

COPY model /tmp/model
COPY resources/atlas-setup.sh /tmp
COPY resources/credentials /tmp

COPY resources/atlas-application.properties /opt/atlas/conf/

USER root
ADD resources/entrypoint.sh /entrypoint.sh
RUN rm -rf /apache-atlas.tar.gz

USER atlas

ENTRYPOINT ["sh", "-c", "/entrypoint.sh"]

EXPOSE 21000
