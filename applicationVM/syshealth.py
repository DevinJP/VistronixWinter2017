import os
import sys
import socket

command = "echo vistronix | sudo -S ./linuxhealthcheck.sh"
host = "10.19.100.161"
port = 8887

s = socket.socket()
s.connect((host, port))

os.system(command)
datafile = open('health-debian.txt','r')
data = datafile.read()
s.send(data)

datafile.close()
s.close()
