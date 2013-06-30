# Rebuild eth0 for Cloned VM - CentOS 6

ifconfig eth0 2>/dev/null >/dev/null
if [ $? -ne 0 ] ; then
        # Rename eth1 with eth0
        echo "UDEV Config..."
        rm /etc/udev/rules.d/70-persistent-net.rules
        # Change ifcfg-eth0 with hostname address (in /etc/hosts)
        echo "Changing eth0 address..."
        mac=`ifconfig eth1 | grep eth1 | awk '{ print $5}'`
        hostname=`hostname`
        ip=`grep $hostname /etc/hosts|cut -s -f 1`
        rm -f /etc/sysconfig/network-scripts/ifcfg-eth1
        cfg=`grep -v IPADDR /etc/sysconfig/network-scripts/ifcfg-eth0 |grep -v HWADDR`
        echo "$cfg" > /etc/sysconfig/network-scripts/ifcfg-eth0
        echo "HWADDR=\"$mac\"" >> /etc/sysconfig/network-scripts/ifcfg-eth0
        echo "IPADDR=\"$ip\"" >> /etc/sysconfig/network-scripts/ifcfg-eth0
        # Apply changes
        echo "Applying changes..."
        service network stop
        service NetworkManager stop
        ifconfig eth1 down
        udevadm trigger
        udevadm control --reload-rules
        service network start
        service NetworkManager start
fi