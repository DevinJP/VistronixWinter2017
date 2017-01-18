import paramiko

command = "vmrun stop /home/user/path/to/Ubuntu.vmx"

clientIP = '0.0.0.0'
clientUser = 'root'
clientPass = 'password'

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(clientIP , username=clientUser , password=clientPass)
ssh_stdin, ssh_stdout, ssh_stderr = ssh.exec_command(command)
