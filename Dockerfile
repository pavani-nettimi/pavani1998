FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/usr/games:${PATH}"

RUN apt-get update && \
    apt-get install -y cowsay fortune-mod netcat-openbsd && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY wisecow.sh /usr/local/bin/wisecow.sh

RUN chmod +x /usr/local/bin/wisecow.sh

EXPOSE 4499

CMD ["/usr/local/bin/wisecow.sh"]
