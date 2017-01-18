import os
import sys
import time

host = "http://10.19.100.219:8080/post-health"
runCommand = "echo vistronix | sudo -S ./linuxhealthcheck.sh"
command = 'curl -X POST -F "txt=@health-kali.txt" ' + host

while 1:
        os.system(runCommand)
        os.system(command)
	time.sleep(3)
