FROM alpine:3.8
MAINTAINER Dockercraft <daniel@topdevbox.com>

LABEL org.label-schema.schema-version="1.0" \
    org.label-schema.name="PHP" \
    org.label-schema.description="alpine3.8, beanstalkd 1.10" \
    org.label-schema.url="https://github.com/dockercraft/beanstalkd" \
    org.label-schema.vendor="Dockercraft (daniel@topdevbox.com)" \
    org.label-schema.license="GPLv2" \
    org.label-schema.build-date="20190111"

# User/Group
ENV MY_USER="www-data" \
	MY_GROUP="www-data" \
	MY_UID="1000" \
	MY_GID="1000"


RUN addgroup -g ${MY_GID} ${MY_GROUP} && \
	adduser -S -u ${MY_UID} -g ${MY_GROUP} ${MY_USER} && \
	apk add --update beanstalkd && \
	mkdir /var/beanstalkd && \
	chown www-data:www-data -R /var/beanstalkd && \
	rm -rf /var/cache/apk/*

# expose port
EXPOSE 11300

CMD ["beanstalkd","-u","www-data","-b", "/var/beanstalkd"]