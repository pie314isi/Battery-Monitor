for ip in `cat /var/lib/misc/dnsmasq.leases | cut -d" " -f3`
	do 
	echo $ip
	echo F | nc -q1 -u -b $ip 4210
	sleep 1
	done

