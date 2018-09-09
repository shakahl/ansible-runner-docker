###############################################################################
# Dockerfile for building image that contains software stack
# provisioned by Ansible.
################################################################################

FROM alpine:3.8

MAINTAINER Soma Szelpal <szelpalsoma@gmail.com>

###############################################################################
# Arguments
###############################################################################

ARG USER
ARG GROUP
ARG PUID
ARG PGID
ARG HOME_FOLDER
ARG docker_FOLDER
ARG DATA_FOLDER

###############################################################################
# Environment
###############################################################################

ENV APK_PACKAGES="sudo bash bc musl coreutils ca-certificates git less openssl openssh openssh-client p7zip python py-cryptography py-setuptools py-cffi py-openssl py-lxml py-pip util-linux bind-tools libffi socat curl mc tzdata findutils gawk sed grep rsync sshpass sudo vim nano zip unzip wget"
ENV APK_DEV_PACKAGES="gcc g++ git make libc-dev python-dev libffi-dev openssl-dev build-base"

#ENV PATH .:$PATH
ENV TERM=xterm

#RUN locale-gen en_US.UTF-8
#ENV LANG=en_US.UTF-8
#ENV LANGUAGE=en_US.UTF-8
#ENV LC_CTYPE=en_US.UTF-8
#ENV LC_ALL=en_US.UTF-8

ENV USER ansible
ENV GROUP ansible
#ENV PUID 1000
#ENV PGID 1000
ENV HOME_FOLDER /ansible
ENV DATA_FOLDER ${HOME_FOLDER}/data

# ==> Specify requirements filename;  default = "requirements.yml"
#ENV REQUIREMENTS requirements.yml

# ==> Specify playbook filename;      default = "playbook.yml"
#ENV PLAYBOOK playbook.yml

# ==> Specify inventory filename;     default = "/etc/ansible/hosts"
#ENV INVENTORY inventory.ini

ENV ANSIBLE_CONFIG /etc/ansible/ansible.cfg

USER root

###############################################################################
# Install dependencies
###############################################################################

#RUN ln -fs /usr/share/zoneinfo/GMT /etc/localtime

RUN apk add --update --no-cache ${APK_PACKAGES}

RUN apk add --update --no-cache --virtual .build-dependencies ${APK_DEV_PACKAGES}

RUN pip install --upgrade pip cffi

RUN pip install --upgrade ansible awscli cloudmonkey boto boto3 docker-py dopy pywinrm pyvmomi pysphere pywinrm

RUN apk del .build-dependencies

RUN  rm -rf /var/cache/apk/* \
  && rm -rf /tmp/*

###############################################################################
# Add user and group
###############################################################################

RUN echo "===> Add user: ${USER}" \
  && addgroup ${GROUP}

RUN echo "===> Add user: ${USER}" \
  && adduser ${USER} -D -h ${HOME_FOLDER} -G ${GROUP} -s /bin/bash \
  && echo ${USER} 'ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

###############################################################################
# Setup environment
###############################################################################
ADD ./docker /docker

ADD ./docker/home/ansible ${HOME_FOLDER}
RUN chown -R ${USER} ${HOME_FOLDER}

RUN cp -r ./docker/home/* /root/
RUN chown -R root:root /root/

ADD ./docker/docker-entrypoint.d /docker-entrypoint.d
RUN chmod -R +x /docker-entrypoint.d

ADD ./docker/docker-entrypoint /docker-entrypoint
RUN chmod +x /docker-entrypoint

ADD ./docker/home/ansible/.bashrc /root/
ADD ./docker/home/ansible/.profile /root/
ADD ./docker/home/ansible/.nanorc /root/
RUN chown -R root:root /root/

ADD ./docker/etc/ansible /etc/ansible
RUN chown -R ${USER}:${GROUP} /etc/ansible

RUN mkdir -p ${DATA_FOLDER} && chown -R ${USER} ${DATA_FOLDER}

USER ${USER}:${GROUP}

WORKDIR ${HOME_FOLDER}

RUN mkdir -p ~/.ssh && touch ~/.ssh/known_hosts

RUN ansible -c local -m setup all > /dev/null

###############################################################################
# Runtime spec
###############################################################################

ENTRYPOINT [ "/docker-entrypoint" ]

CMD ["bash"]
