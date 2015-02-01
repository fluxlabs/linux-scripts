#!/bin/sh
export LANG=C
# +--------------------------------------------------------------------+
# Script for imapsync.pl
# +--------------------------------------------------------------------+
#
# Author - Jeremy McSpadden
# Contact - jeremy@fluxlabs.net
# Copyright (C) 2013  http://www.fluxlabs.net
#
# Sourced at https://github.com/fluxlabs

echo "------------------------------------------------------------------------------";
echo "I M A P  S Y N C  U T I L I T Y";
echo "------------------------------------------------------------------------------";
echo -n ""
while :
do
echo ""
echo "What email would you like to sync from?"
echo "ie: you@domain.com"
IFS= read -p "Email: " emaila
IFS= read -p "Email Again: " emaila2
[[ $emaila = "$emaila2" ]] && break
echo ''
echo 'Email does not match. Please try again.'
echo ''
done

while :
do
echo ""
echo "From what server?"
echo "ie: imap.domain.com"
IFS= read -p "IMAP: " imapa
IFS= read -p "IMAP Again: " imapa2
[[ $imapa = "$imapa2" ]] && break
echo ''
echo 'Servers do not match. Please try again.'
echo ''
done

while :
do
echo ""
echo "What email would you like to sync to?"
echo "ie: you@domain.com"
IFS= read -p "Email: " emailb
IFS= read -p "Email Again: " emailb2
[[ $emailb = "$emailb2" ]] && break
echo ''
echo 'Email does not match. Please try again.'
echo ''
done

while :
do
echo ""
echo "To what server??"
echo "ie: localhost"
IFS= read -p "IMAP: " imapb
IFS= read -p "IMAP Again: " imapb2
[[ $imapb = "$imapb2" ]] && break
echo ''
echo 'Servers do not match. Please try again.'
echo ''
done

./imapsync --host1 $imapa   --user1 $emaila   --password1 "$passa" \
		   --host2 $imapb   --user2 $emailb   --password2 "$passb"