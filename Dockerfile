#################################################
#                 Dockerfile to build
# - MySQL Server
# - RabbitMQ
# - Java8
# - Node.js
# - Xvfb
# -Firefox
# -Chrome
#################################################

FROM ubuntu
MAINTAINER BPetkov

# Update the repository sources list
RUN apt-get update

# My SQL Server
###############
RUN apt-get install mysql-server
RUN /bin/rm -rf /var/lib/mysql/*

ADD initialize_andstart_mysql /user/sbin/initialize_and_start_mysql
ADD listen_on_all_addresses.cnf /etc/conf.d/listen_on_all_addresses.cnf

EXPOSE 3306
CMD[ "/usr/sbin/initialize_and_start_mysql"]

# RabbitMQ
#############

#RUN apt-get update
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y rabbitmq-server pwgen
#RUN rabbitmq-plugins enable rabbitmq-management

#ADD run.sh /run.sh
#ADD set_rabbitmq_password.sh /set_rabbitmq_password.sh
#RUN chmod 755 ./*.sh

#EXPOSE 5672 15672
#CM ["/run.sh"]

# JAVA 8
############

#RUN sed -i.bak 's/main$/main universe/' /etc/apt/sources.list
#RUN apt-get update
#RUN dpkg-divert --local --rename --add /sbin/initctl
#RUN apt-get update && apt-get -y install python-software-properties wget curl
#RUN add-apt-repository ppa:webupd8team/java
#RUN apt-get update
#RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /user/bin/debconf-set-selection
#RUN apt-get -y install oracle-java8-installer && apt-get clean
#RUN update-alternatives --dispaly java
#RUN echo "JAVA_HOME=/user/lib/jvm/java-8-oracle" >> /etc/enviroment
#RUN echo '# /lib/init/fstab: cleared out for bare-bones lxc' > /lib/init/fstab
#RUN ln -s proc/selc/mounts /etc/mtab