#!/bin/bash
# Atomiccorp Rules Updater for CPanel
# Jeremy McSpadden
# Flux Labs
# jeremy at fluxlabs dot net
# 02/17/13
#
# Just edit your username and password

USER=username
PASS=password

# ==== NO NEED TO EDIT BELOW ===

cd /usr/src
wget --user=${USER} --password=${PASS} https://updates.atomicorp.com/channels/rules/subscription/VERSION
MOD=$(grep MODSEC VERSION | awk -F = '{print $2}')
CLM=$(grep CLAMAV VERSION | awk -F = '{print $2}')

cd /etc/httpd/conf/modsec_rules
rm -rf *
wget --user=${USER} --password=${PASS} http://updates.atomicorp.com/channels/rules/subscription/modsec-${MOD}.tar.gz
gzip -d modsec*.tar.gz
tar -xf modsec*.tar
cd modsec
mv 15_asl_paranoid_rules.conf 15_asl_paranoid_rules.conf.old
mv 70_asl_csrf_experimental.conf 70_asl_csrf_experimental.conf.old
mv 11_asl_adv_rules.conf 11_asl_adv_rules.conf.old
mv * ../.
cd /etc/httpd/conf/modsec_rules
rm -rf modsec*
cat "/etc/asl/whitelist" >>  /etc/httpd/conf/modsec_rules/whitelist.txt
/etc/init.d/httpd restart

cd /usr/local/share/clamav
rm -rf ASL*
wget --user=${USER} --password=${PASS} http://updates.atomicorp.com/channels/rules/subscription/clamav-${CLM}.tar.gz
tar zxvf clamav-*
mv clamav/* .
chmod og+r ASL*
rm -rf clamav*
/etc/init.d/clamd restart

rm -rf /usr/src/VERSION