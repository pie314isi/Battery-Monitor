logread > /tmp/bootlog.txt
ifconfig > /tmp/ifconfig.txt
/opt/vc/bin/vcgencmd measure_temp > /tmp/cputemp.txt

export PATH=~/.local/bin:$PATH
export AWS_CONFIG_FILE="/root/.aws/config"
export AWS_PROFILE=user2
export HOME=/root

nc -z 8.8.8.8 53  >/dev/null 2>&1
online=$?
if [ $online -eq 0 ]; then
	/root/.local/bin/aws s3 mv /tmp/bootlog.txt s3://mornington-admin
	/root/.local/bin/aws s3 mv /tmp/ifconfig.txt s3://mornington-admin
	/root/.local/bin/aws s3 mv /tmp/cputemp.txt s3://mornington-admin
	/root/.local/bin/aws s3 cp s3://mornington-admin/remoteip.txt /tmp/
	
fi


