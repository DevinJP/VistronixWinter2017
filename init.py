import os
import paramiko

killCommand = "killall -9 python"
startCommand = "./radio.sh"
command = killCommand + "; " + startCommand

clientIP = '192.168.110.131'
clientUser = 'application'
clientPass = 'vistronix'

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(clientIP , username=clientUser , password=clientPass)
ssh_stdin, ssh_stdout, ssh_stderr = ssh.exec_command(command)
