FROM alpine:latest

RUN apk add mosquitto
RUN mkdir -p /mosquitto/data
RUN mkdir -p /mosquitto/logs
RUN mkdir -p /mosquitto/certs

COPY ./mosquitto.conf /mosquitto/config/mosquitto.conf
COPY ./certs/ /mosquitto/certs/

RUN chown -R mosquitto:mosquitto /mosquitto/

CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]