FROM keymetrics/pm2:8-alpine

RUN apk add --update openssh

COPY . /opt/poc-ci

RUN  cd /opt/poc-ci && npm install 

# RUN cd /opt/poc-ci && ls

# COPY ./id_rsa /tmp/id_rsa

# RUN \
#     chmod 400 /tmp/id_rsa && \
#     eval $(ssh-agent) && \
#     echo -e "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
#     ssh-add /tmp/id_rsa
COPY entry-script.sh /entry-script.sh

RUN chmod +x /entry-script.sh

ENTRYPOINT [ "/entry-script.sh"]



# CMD ["pm2-runtime", "start", "/opt/poc-ci/pm2.json" ]
