FROM httpd:2.4
MAINTAINER Amar Parmar <aparmar@mylinkx.com>

ENV HOME /apache
ENV DATA $HOME/data
ENV LETSENCRYPT_HOME /etc/letsencrypt

# Base setup
RUN apt-get -y update && \
    apt-get install -q -y curl apache2 software-properties-common certbot python-certbot-apache && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# make directories
RUN mkdir -p $HOME/scripts
RUN mkdir -p $DATA

# configure letsencrypt
RUN rm -rf /etc/letsencrypt/accounts
RUN ln -s $DATA/letsencrypt/accounts /etc/letsencrypt/accounts

RUN rm -rf /etc/letsencrypt/archive
RUN ln -s $DATA/letsencrypt/archive /etc/letsencrypt/archive

RUN rm -rf /etc/letsencrypt/csr
RUN ln -s $DATA/letsencrypt/csr /etc/letsencrypt/csr

RUN rm -rf /etc/letsencrypt/keys
RUN ln -s $DATA/letsencrypt/keys /etc/letsencrypt/keys

RUN rm -rf /etc/letsencrypt/live
RUN ln -s $DATA/letsencrypt/live /etc/letsencrypt/live


# configure apache
RUN rm -rf /var/log/apache2
RUN ln -s $DATA/log /var/log/apache2

RUN rm -rf /etc/apache2/sites-enabled/000-default.conf
RUN rm -rf /etc/apache2/sites-available
RUN ln -s $DATA/sites-available /etc/apache2/sites-available

# add scripts from this project
COPY ./scripts $HOME/scripts

# Stuff
EXPOSE 80
EXPOSE 443

CMD ["/apache/scripts/boot.sh"]
