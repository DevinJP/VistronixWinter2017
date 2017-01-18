from __future__ import print_function
import os
import sys
import paramiko

command = "nc -w 3 -z 192.168.202.129 22 > /dev/null ; echo $?"

clientIP = '10.19.100.161'
clientUser = 'comms'
clientPass = 'vistronix'

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(clientIP , username=clientUser , password=clientPass)
ssh_stdin, ssh_stdout, ssh_stderr = ssh.exec_command(command)

print (ssh_stdout.read(5))
