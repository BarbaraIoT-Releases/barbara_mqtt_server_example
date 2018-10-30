FROM alpine:latest

RUN apk add mosquitto
RUN mkdir -p /mosquitto/data
RUN mkdir -p /mosquitto/logs
RUN mkdir -p /mosquitto/certs

COPY ./mosquitto.conf /mosquitto/config/mosquitto.conf
COPY ./certs/ /mosquitto/certs/

RUN chmod 400 /mosquitto/certs/ca.crt /mosquitto/certs/server.key
RUN chmod 444 /mosquitto/certs/server.crt

CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]