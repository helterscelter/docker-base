FROM ubuntu:xenial
MAINTAINER Wurstmeister 


RUN apt-get update && apt-get upgrade -y; \
  apt-get install -y --fix-missing --no-install-recommends \
    unzip \
    wget \
    supervisor \
    openssh-server \
    software-properties-common \
  ; \
  apt-get clean; \
  du -h /var/cache

RUN /usr/bin/add-apt-repository -y ppa:webupd8team/java 

# accept the oracle java license
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

# download and install the latest java
RUN apt-get update; \
  apt-get install -y --no-install-recommends oracle-java8-installer oracle-java8-set-default ;\
  apt-get clean; \
  rm -Rf /var/cache/oracle-jdk8-installer ; 



# expose the JAVA_HOME for this base image
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle/

# prep for running sshd
RUN mkdir /var/run/sshd

#RUN echo 'root:wurstmeister' | chpasswd
#RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22
