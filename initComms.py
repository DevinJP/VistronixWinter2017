import paramiko

command = "vmrun start /home/janzaldi/vmware/Ubuntu\ 64-bit/Ubuntu\ 64-bit.vmx nogui"

clientIP = '10.19.100.101'
clientUser = 'janzaldi'
clientPass = 'vistronix'

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(clientIP , username=clientUser , password=clientPass)
ssh_stdin, ssh_stdout, ssh_stderr = ssh.exec_command(command)
