FROM alpine

RUN wget https://github.com/getsops/sops/releases/download/v3.9.1/sops-v3.9.1.linux.amd64 -O /usr/local/bin/sops \
    && chmod +x /usr/local/bin/sops 

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
