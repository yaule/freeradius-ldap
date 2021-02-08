
# quick start


```sh
docker run -it --rm --name freeradius-ldap \
        -p 1812:1812/udp -p 1813:1813/udp \
        -e RADIUS_SECRET=radiussecret \
        -e RADIUS_LDAP_HOST=127.0.0.1 \
        -e RADIUS_LDAP_ADMIN_DN='cn=admin,dc=samba,dc=com' \
        -e RADIUS_LDAP_BASE_DN=ou=users,dc=samba,dc=com \
        -e RADIUS_LDAP_PASSWD=password \
        kasen/freeradius-ldap
```

```sh
docker run -it --rm --name freeradius-ldap \
        -p 1812:1812/udp -p 1813:1813/udp \
        -v $(pwd)/sites-available-default:/etc/freeradius/3.0/sites-available/default:ro \
        -v $(pwd)/mods-available-ldap:/etc/freeradius/3.0/mods-available/ldap \
        -v $(pwd)/mods-available-eap:/etc/freeradius/3.0/mods-available/eap:ro \
        -v $(pwd)/clients.conf:/etc/freeradius/3.0/clients.conf:ro \
        kasen/freeradius-ldap

```


# test auth

    echo "User-Name=testuser,User-Password=testpasswd" | radclient localhost:1812 auth radiussecret
