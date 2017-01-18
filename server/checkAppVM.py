from __future__ import print_function
import os
import sys
import paramiko

appIP = "0.0.0.0"
command = "nc -w 3 -z " + appIP + " 22 > /dev/null ; echo $?"

clientIP = '0.0.0.0'
clientUser = 'root'
clientPass = 'password'

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(clientIP , username=clientUser , password=clientPass)
ssh_stdin, ssh_stdout, ssh_stderr = ssh.exec_command(command)

print (ssh_stdout.read(5))
