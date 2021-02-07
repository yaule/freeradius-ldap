#!/bin/bash

set -e -x

if [[ -n $RADIUS_SECRET ]] && [[ -n $RADIUS_LDAP_HOST ]] && [[ -n $RADIUS_LDAP_ADMIN_DN ]] && [[ -n $RADIUS_LDAP_BASE_DN ]] && [[ -n $RADIUS_LDAP_PASSWD ]] ; then

    if [[ -z $RADIUS_SECRET ]] ; then
        echo "ERROR: $RADIUS_SECRET does not exists"
        exit 15
    fi
    if [[ -z $RADIUS_LDAP_HOST ]] ; then
        echo "ERROR: $RADIUS_LDAP_HOST does not exists"
        exit 15
    fi
    if [[ -z $RADIUS_LDAP_ADMIN_DN ]] ; then
        echo "ERROR: $RADIUS_LDAP_ADMIN_DN does not exists"
        exit 15
    fi
    if [[ -z $RADIUS_LDAP_BASE_DN ]] ; then
        echo "ERROR: $RADIUS_LDAP_BASE_DN does not exists"
        exit 15
    fi
    if [[ -z $RADIUS_LDAP_PASSWD ]] ; then
        echo "ERROR: $RADIUS_LDAP_PASSWD does not exists"
        exit 15
    fi
    cp /config/mods-available-eap /etc/freeradius/3.0/mods-available/eap

    cp /config/sites-available-default /etc/freeradius/3.0/sites-available/default


    eval "cat <<EOF
$(</config/clients.conf)
EOF" 2>/dev/null >/etc/freeradius/3.0/clients.conf


    sed -i s/RADIUS_LDAP_HOST/$RADIUS_LDAP_HOST/g /config/mods-available-ldap
    sed -i s/RADIUS_LDAP_ADMIN_DN/$RADIUS_LDAP_ADMIN_DN/g /config/mods-available-ldap
    sed -i s/RADIUS_LDAP_PASSWD/$RADIUS_LDAP_PASSWD/g /config/mods-available-ldap
    sed -i s/RADIUS_LDAP_BASE_DN/$RADIUS_LDAP_BASE_DN/g /config/mods-available-ldap

    cp /config/mods-available-ldap /etc/freeradius/3.0/mods-available/ldap 



fi

echo "start"

ln -s /etc/freeradius/3.0/mods-available/ldap /etc/freeradius/3.0/mods-enabled/ldap

chown freerad:freerad /etc/freeradius/3.0/mods-available/ldap

chown freerad:freerad /etc/freeradius/3.0/mods-enabled/ldap

exec freeradius -s
