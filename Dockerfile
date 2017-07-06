FROM debian:jessie-slim
MAINTAINER Jérôme Devoucoux <jdevoucoux@gmail.com>

WORKDIR /opt

# Install required softs
RUN apt-get update && apt-get install -y software-properties-common wget apt-transport-https

# Install Java
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get update && apt-get install -y oracle-java8-set-default

# Install ElasticSearch
RUN apt-get install -y
RUN echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-5.x.list
RUN apt-get update && apt-get install -y elasticsearch=5.4.1

EXPOSE 9200, 9300
CMD systemctl start elasticsearch.service
