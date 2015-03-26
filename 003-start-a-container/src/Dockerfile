FROM node:0.10-slim

RUN npm -g install wiki

CMD ["/usr/local/bin/wiki", "-p", "3000", "--data", "/data"]

VOLUME /data
EXPOSE 3000
