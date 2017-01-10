import os
import sys
import socket
import paramiko
from shutil import copy2
from shutil import copyfile

command = "python syshealth.py"
host = "10.19.100.161"
port = 8887

clientIP = '192.168.110.131'
clientUser = 'application'
clientPass = 'vistronix'

tempTxtFile = "public/data.txt"
endTxtFile = "public/health-debian.txt"

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(clientIP , username=clientUser , password=clientPass)
ssh_stdin, ssh_stdout, ssh_stderr = ssh.exec_command(command)

s = socket.socket()
s.bind((host, port))
s.listen(2)

datafile = open(tempTxtFile,'rw+')
connection, addr = s.accept()

line = connection.recv(8192)
while (line):
        datafile.write(line)
        line = connection.recv(8192)

copy2(tempTxtFile, endTxtFile)
datafile.close()
s.close()

