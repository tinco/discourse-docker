FROM phusion/passenger-ruby21:0.9.11

MAINTAINER Tinco Andringa "twistlock@tinco.nl"

RUN echo "debconf debconf/frontend select Teletype" | debconf-set-selections &&\
    apt-get update && apt-get -y install build-essential libssl-dev libyaml-dev git libtool \
    libxslt-dev libxml2-dev libpq-dev gawk curl pngcrush imagemagick software-properties-common

# Discourse specific bits
RUN useradd discourse -s /bin/bash -m -U &&\
    mkdir /app && cd /app &&\
     git clone --depth 1 https://github.com/discourse/discourse.git . &&\
     chown -R discourse:discourse /app &&\
     sudo -u discourse RAILS4=1 bundle install --deployment \
         --without test --without development &&\
    cd /app/vendor/bundle &&\
       find . -name tmp -type d | xargs rm -rf && cd /app

ADD start.sh /app/start
ADD rake.sh /app/rake

RUN chmod +x /app/start /app/rake
