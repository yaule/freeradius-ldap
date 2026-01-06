FROM debian:13

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install freeradius freeradius-ldap -y

# copy config
COPY mods-available-eap /config/mods-available-eap

COPY sites-available-default /config/sites-available-default

COPY clients.conf /config/clients.conf

COPY mods-available-ldap /config/mods-available-ldap

COPY start.sh /bin/start.sh

CMD start.sh
