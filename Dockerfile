FROM ubuntu:latest as base 
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base AS mk
ARG TAGS
RUN addgroup --gid 1000 mk489
RUN adduser --gecos mk489 --uid 1000 --gid 1000 --disabled-password mk489
USER mk489
WORKDIR /home/mk489

FROM mk
COPY . .
CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]

