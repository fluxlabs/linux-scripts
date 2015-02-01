#!/bin/bash
# Atomic Clamav Rules for Centos/Baruwa Installer
# Jeremy McSpadden
# Flux Labs
# jeremy at fluxlabs dot net
# 01/26/14
#
# Just edit your username and password

USER=username
PASS=password

# ==== NO NEED TO EDIT BELOW ===

cd /usr/src
wget --user=${USER} --password=${PASS} https://www.atomicorp.com/channels/rules/subscription/VERSION
MOD=$(grep MODSEC VERSION | awk -F = '{print $2}')
CLM=$(grep CLAMAV VERSION | awk -F = '{print $2}')


cd /var/lib/clamav
rm -rf ASL*
cd /tmp
wget --user=${USER} --password=${PASS} http://www.atomicorp.com/channels/rules/subscription/clamav-${CLM}.tar.gz
tar zxvf clamav-*
mv clamav/* /var/lib/clamav/.
cd /var/lib/clamav
chmod og+r ASL*
rm -rf /tmp/clamav*
chown clamav:
/etc/init.d/clamd restart

rm -rf /usr/src/VERSION