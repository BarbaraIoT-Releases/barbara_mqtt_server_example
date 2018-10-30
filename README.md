<h1 align="center">
  <a href="https://barbaraiot.com/"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADICAMAAACahl6sAAAAb1BMVEXoPkf////pRk7oQUr//PzmMTroQEj1rbDnN0DsXWTnND72sLPubXL85eXoPEX/+/zwfoP97e33urzykJTucXbtZGrwhIn4xsfqS1PzmZ31qKv0oKTtaG797+/+9PTxiI361tfrU1v73t/4wsP609NHvHPPAAAD1UlEQVR4nO3c23baMBCFYctjyY4BYXMIh0AhSd//GStMDmA5TS5m1IHu/6bU7Wr5lkwLeKxsnd9HWe7vowBx2V2U+3/9DJgCRFuAaAsQbQGiLUC0BYi2ANEWINoCRFuAaAsQbQGiLUC0BYi2ANEWINoCRFuAaAsQbQGiLUC0BYi2ANEWJ8S57HIWzBHfH/19nBBvM3IfUVWnnGljhHhXTi47LqqEa8IHITs31/1aJ5wz5ISMzPSCURTmIeGScEJKU1wvyUN1mysCCEeARAHCEyBRgPAESBQgPAESBQhPgEQBwhMgUf8DxFGXqCoJxHZV3glaUkD8odxuN80yt9aLUeQhzq/fDrezJg8Urr/wOnkI1TtTnOosm9zKLEoCiJ2/Hz9h2kZmUVJAZhfHw6ORl5CkeI0cL4+HVflNAhJxSHit/7o+GiQZ/9f04hCqx8b0Ja81+5LIQz5f6xeSueWWJIDMIkigPHO/DZN/sfuXGBJOLu4lkYY4/zztM7qWzFezpCFULwbOrHBoxrwk4hC7MdMBCfuVUmEIObs6r0C0JI+8SyINyVxZPs0mEYX93JL/n70Kn6mypo0WZUKsYzAJ3muFD7mZXU+iNeH9RJ/oyweyu+hFsmB9n5LqWxQKL/riGnJgfZGkg8z7kKfbhPT/YyxMeaOQ3rv5wowAGQqQKEB4AiQKEJ4AiQKEJ0CiAOEJkChAeAIkChCeAIkChCdAogDhCZAostt7+e5303+qF1dAyD7ezrfxf3uqp/tGb+X6SDw9M3Hv80w0MCOk9YqV88/Rc91a383Jko8nUpjHURhvA3fVsf9kTUm2ripr876jMC+8exswQgb+2Qpn19NiuWy2+/g6+1brdfZunLRfET34+PmYd/iMdfMKH59b3WRpMTDBwXxmsULIHoYmgYbin6HjXREXzTd85WiJeT6TFUK2+SmEeTaIe4MXql9/IinMin3MlBfi/DoeAxo6sfj352Decofqh+I7SfgNS81zv+fIjr+RhF8es0/9CmyCRHa5N8ODpV1Ts18KOAR2c6J6vTJfUcLh1Zr/vMpEtqUiXx32ZmC2tAiM9lDJ3NMjsb+WczbftN1Tf7uRp5ief5xscutk7rKS2SgsfP6g5rW9XpB21pDYLVZSO56dPkrZfDcfrY7dDlWr0XwnetOb3NZtjsjX1tY+PHDnRyR0VnVJ7kHX3RCanXdxk74xNMVmepLr8Bl2BdQWINoCRFuAaAsQbQGiLUC0BYi2ANEWINoCRFuAaAsQbQGiLUC0BYi2ANEWINoCRFuAaAsQbQGiLUC0BYi27gXyB5auTCuBJkfdAAAAAElFTkSuQmCC" alt="Barbara IoT logo" width=200"></a>
<br>
  Barbara MQTT Server Example
</h1>


# Introduction

This is an example to set up a secure MQTT server over TLS. The server runs encapsulated in a Docker container, and its launched using Docker compose.

# Installation

In order to run this software, it is necessary to install Docker CE. [Find the instructions here.](https://docs.docker.com/install/) Also docker compose is required. [Install docker compose.](https://docs.docker.com/compose/install/)

# Generate the certificates
Openssl is required to generate the certificates. 

### Generate the Certificate Authority
To generate the certificate authority run:
>openssl req -nodes -new -x509 -days 1000 -extensions v3_ca -keyout certs/ca.key -out certs/ca.crt

### Generate the Server Certificates
Generate the server key using:
>openssl genrsa -out certs/server.key 2048

Generate a certificate signing request to send to the CA running:
>openssl req -out certs/server.csr -key certs/server.key -new

Send the CSR to the CA, or sign it with your CA key with:
>openssl x509 -req -in certs/server.csr -CA certs/ca.crt -CAkey certs/ca.key -CAcreateserial -out certs/server.crt -days 1000

**Note:** When prompted for the CN (Common Name), please enter either your server (or broker) hostname or domain name.

### Generate the Client Certificates
Generate a client key using:
>openssl genrsa -out certs/client.key 2048

Generate a certificate signing request to send to the CA running:
>openssl req -nodes -out certs/client.csr -key certs/client.key -new

Send the CSR to the CA, or sign it with your CA key with:
>openssl x509 -req -in certs/client.csr -CA certs/ca.crt -CAkey certs/ca.key -CAcreateserial -out certs/client.crt -days 1000

# Start up the MQTT server
Once all the necessary certificates are generated and placed in `/certs` folder, in order to start the MQTT server execute the following line: 
> docker-compose up

To run the server in the background, just append a `-d` flag to the command:
> docker-compose up -d


### Build again the containers
After doing any modification to the code, the Docker containers must be rebuilt, to achieve so, we have to stop them and then run the following lines:
>docker-compose build
>docker-compose up

### Stop a running container in the background
To list the running containers in the server, run the command:
>docker ps

Identify the containers you want to stop, and run:
>docker stop 7f6ecaf856f9

In case you want to stop and also delete a running container, execute: 
>docker rm -f  7f6ecaf856f9

