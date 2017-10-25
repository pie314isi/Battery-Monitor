

https://wiki.wemos.cc/products:d1:d1_mini_lite

https://forum.wemos.cc/topic/274/how-to-flash-the-new-d1-mini-lite-with-arduino/2

https://ibeblog.com/2014/04/23/minibian-first-steps/
https://petr.io/en/blog/2015/11/09/read-only-raspberry-pi-with-jessie/

need to use the same method to make /var/lib/misc writeable on /tmp for dnsmasq to assign dhcp leases.

raspi only seems to be bale to host 32 wifi connections. both routers
(wrt54g and tplink) seem to be limited to 127

make raspi be an access point - use it for internal admin. separate router is for hosting wifi modules
https://frillip.com/using-your-raspberry-pi-3-as-a-wifi-access-point-with-hostapd/

http://lists.thekelleys.org.uk/pipermail/dnsmasq-discuss/2010q3/004384.html

http://docs.aws.amazon.com/cli/latest/userguide/awscli-install-linux.html

apt-get install python-pip
http://docs.aws.amazon.com/cli/latest/userguide/awscli-install-linux.html

configure logrotate to do hourly updates

receive udp packets
socat UDP-RECV:4120 STDOUT | cat > udp.txt &

timestamped - put this in rc.local
socat UDP-RECV:4120 STDOUT | ts %Y-%m-%dT%T, >> /tmp/batteries.log&

raspi at mornington sets up a reverse tunnel to whatever ip address is
placed in the file remoteip.txt on port 1022. username pie, needs to
have a shared ssh key

once the tunnel is set up, it forwards port 2022 on localhost back into
mornington

from within mornington, on the Research's network:

1) Linksys router (hostname: batteryrouter, SSID: batteryfarm). I
have just given it a static IP on your network. it’s at 192.168.1.146.
It has port 22 open for remote ssh management and port 2022 forwarded to
the batteryserver. It’s configured for NAT and the local IP range is
192.168.120.xxx

2) a raspberry pi server. It has a static IP of 192.168.120.192. It has
port 22 open for ssh access.

From the research network, you can ssh in to the raspberry pi at
192.168.1.146:2022 or into the linksys router at 192.168.1.146:22

the ip addresses of individual wifi modules are not controlled. If you
need to address a particular one, the  you need to issue a broadcast "I"
command to get all modules to identify themselves by ip.




