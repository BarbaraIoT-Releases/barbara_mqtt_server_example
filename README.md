<h1 align="center">
  <a href="https://www.barbaraiot.com">Barbara IoT</a><br>
  Barbara MQTT Server Example
</h1>


# Introduction

This is an example to set up a secure MQTT server over TLS. The server runs encapsulated in a Docker container, and its launched using Docker compose.
<br />
<br />
# Installation

In order to run this software, it is necessary to install Docker CE. [Find the instructions here.](https://docs.docker.com/install/) Also docker compose is required. [Install docker compose.](https://docs.docker.com/compose/install/)
<br />
<br />
# Generate the certificates
Openssl is required to generate the certificates. 
<br />
### Generate the Certificate Authority
To generate the certificate authority run:
>openssl req -nodes -new -x509 -days 1000 -extensions v3_ca -keyout certs/ca.key -out certs/ca.crt
<br />
### Generate the Server Certificates
Generate the server key using:
>openssl genrsa -out certs/server.key 2048

Generate a certificate signing request to send to the CA running:
>openssl req -out certs/server.csr -key certs/server.key -new

Send the CSR to the CA, or sign it with your CA key with:
>openssl x509 -req -in certs/server.csr -CA certs/ca.crt -CAkey certs/ca.key -CAcreateserial -out certs/server.crt -days 1000

**Note:** When prompted for the CN (Common Name), please enter either your server (or broker) hostname or domain name.
<br />
### Generate the Client Certificates
Generate a client key using:
>openssl genrsa -out certs/client.key 2048

Generate a certificate signing request to send to the CA running:
>openssl req -nodes -out certs/client.csr -key certs/client.key -new

Send the CSR to the CA, or sign it with your CA key with:
>openssl x509 -req -in certs/client.csr -CA certs/ca.crt -CAkey certs/ca.key -CAcreateserial -out certs/client.crt -days 1000
<br />
<br />
# Start up the MQTT server
Once all the necessary certificates are generated and placed in `/certs` folder, in order to start the MQTT server execute the following line: 
> docker-compose up

To run the server in the background, just append a `-d` flag to the command:
> docker-compose up -d
<br />

### Build again the containers
After doing any modification to the code, the Docker containers must be rebuilt, to achieve so, we have to stop them and then run the following lines:
>docker-compose build
>docker-compose up
<br />

### Stop a running container in the background
To list the running containers in the server, run the command:
>docker ps

Identify the containers you want to stop, and run:
>docker stop 7f6ecaf856f9

In case you want to stop and also delete a running container, execute: 
>docker rm -f  7f6ecaf856f9
