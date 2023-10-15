FROM alpine:3.18

RUN apk add --no-cache python3 py3-pip git sshpass bash ansible openssh nano

RUN pip install  junit_xml

# Disable strict host checking

ENV ANSIBLE_HOST_KEY_CHECKING=False 

WORKDIR /ansible



# RUN adduser -D -h /home/ansible/ -s /bin/bash ansible

# USER ansible
