# Jenkins Pipeline Agent Dockerfile, note name is not .DockerFile 
# File has instructions to build image to act as the pipeline agent run time and to allow use of various test tools and linters
# FROM alpine:latest

FROM alpine:latest
MAINTAINER "Andy Burrows" <andy.burrows@dxc.com>

ARG JENKINS_GID=1002
ARG JENKINS_UID=1002

# Change to root user
USER root

RUN addgroup --gid ${JENKINS_GID:-1002} jenkins
RUN adduser -S -u ${JENKINS_UID:-1002} -D -h "$(pwd)" -G jenkins jenkins

ENV USER=jenkins

ARG PACKER_VERSION=1.6.4

RUN apk --update add python3 py3-pip python3-dev

RUN apk update && \
	apk add ansible \
	gcc \
	libffi \
	libffi-dev \
	musl-dev \
	make \
	openssl \
	openssl-dev \
	curl \
	zip \
	git \
	jq

RUN apk add --update openssh

RUN python3 -m pip install --upgrade pip

ADD requirements.txt .

RUN pip install -r requirements.txt

RUN curl -O https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
		&& unzip -d /usr/local packer_${PACKER_VERSION}_linux_amd64.zip \
		&& ln -s /usr/local/packer /usr/local/bin/packer.io

#RUN apk -v --purge del py3-pip
RUN rm /var/cache/apk/*
WORKDIR /build
USER jenkins

WORKDIR /build

#drop back to jenkins
USER jenkins
