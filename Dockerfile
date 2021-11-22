FROM mongo:4.4.1

RUN apt-get update && \
    apt-get install -y cron python3 python3-pip curl && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install awscli
RUN pip3 install awscli-plugin-endpoint
RUN aws configure set plugins.endpoint awscli_plugin_endpoint

ADD backup.sh /backup.sh
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && chmod +x /backup.sh

VOLUME /backup

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]