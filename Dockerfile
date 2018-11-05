FROM alpine:latest

RUN apk add mosquitto
RUN mkdir -p /mosquitto/data
RUN mkdir -p /mosquitto/logs
RUN mkdir -p /mosquitto/certs

COPY ./mosquitto.conf /mosquitto/config/mosquitto.conf
COPY ./certs/ /mosquitto/certs/

RUN touch /mosquitto/logs/mosquitto.log

RUN chown -R mosquitto:mosquitto /mosquitto/

RUN chmod 400 /mosquitto/certs/ca.crt /mosquitto/certs/server.key
RUN chmod 444 /mosquitto/certs/server.crt

EXPOSE 8883

RUN chmod 777 /mosquitto/logs/mosquitto.log
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
RUN chmod 777 /mosquitto/logs/mosquitto.log
