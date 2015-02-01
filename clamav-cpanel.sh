#!/bin/sh
export LANG=C
# +--------------------------------------------------------------------+
# ClamAV Installer for cPanel hosts
# +--------------------------------------------------------------------+
#
# Author - Jeremy McSpadden
# Contact - jeremy@fluxlabs.net
# Copyright (C) 2013  http://www.fluxlabs.net
#
# Sourced at https://github.com/fluxlabs
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# +--------------------------------------------------------------------+

# Versions

clamstable = 0.98.6			# Stable ClamAV
clamurl = http://downloads.sourceforge.net/project/clamav/clamav/{$clamstable}/clamav-{$clamstable}.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fclamav%2Ffiles%2Fclamav%2F{$clamstable}%2Fclamav-{$clamstable}.tar.gz%2Fdownload%3Fuse_mirror%3Diweb&ts=1422829969&use_mirror=iweb 					# ClamAV File URL


# Install script

useradd clamav; groupadd clamav
mkdir /usr/local/share/clamav
chown clamav:clamav /usr/local/share/clamav
cd /usr/src; wget $clamurl/$clamstable
tar -xzf clamav-*
cd clamav* 
./configure --disable-zlib-vcheck 
make
make install

mv -fv /usr/local/etc/freshclam.conf.sample /usr/local/etc/freshclam.conf
mv -fv /usr/local/etc/clamd.conf.sample /usr/local/etc/clamd.conf