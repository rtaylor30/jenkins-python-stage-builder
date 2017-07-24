FROM alpine:3.6

LABEL maintainer=webframeworks@manheim.com
LABEL repo=rtaylor30/jenkins-python-stage-builder

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
      && apk add --no-cache python3 python3-dev curl tar unzip zip git make ruby ruby-rdoc ruby-irb \
      && gem install awssume --no-ri --no-rdoc \
      && ln -s $(which python3) /usr/bin/python \
      && ln -s $(which pip3) /usr/bin/pip \
      && pip install --upgrade pip \
      && pip install awscli virtualenv Jinja2 \
      && pip install awsebcli==3.10.2 \
      && curl -LO https://releases.hashicorp.com/terraform/0.9.11/terraform_0.9.11_linux_amd64.zip \
      && curl -LO https://releases.hashicorp.com/consul/0.8.5/consul_0.8.5_linux_amd64.zip \
      && unzip consul_0.8.5_linux_amd64.zip \
      && unzip terraform_0.9.11_linux_amd64.zip \
      && mv terraform /usr/bin/ \
      && mv consul /usr/bin/ \
      && chmod +x /usr/bin/terraform \
      && chmod +x /usr/bin/consul \
      && rm consul_0.8.5_linux_amd64.zip terraform_0.9.11_linux_amd64.zip

ENTRYPOINT ["/bin/sh", "-c"]
