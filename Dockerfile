FROM ubuntu:xenial
MAINTAINER Helter Scelter


# expose the JAVA_HOME for this base image
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle/

# upgrade any out of date packages from the base image, and install commonly used dependencies
RUN apt-get update && apt-get upgrade -y; \
  apt-get install -y --fix-missing --no-install-recommends \
    unzip \
    wget \
    supervisor \
    openssh-server \
    software-properties-common \
    jq \
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


# prep for running sshd
RUN mkdir /var/run/sshd

# copy default settings and templates for supervisord to the proper locations
ADD supervisor /etc/supervisor

# add template engine/script and all other base-scripts to /usr/bin so derived containers can use it
ADD usr/bin /usr/bin


#RUN echo 'root:wurstmeister' | chpasswd
#RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

#EXPOSE 22
