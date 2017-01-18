# VistronixWinter2017

## Getting Started

#### Install VMWare
Install VMWare Workstation Player [here](http://www.vmware.com/products/player/playerpro-evaluation.html)

#### Clone the Repo
Either download the zip or clone the repository
```linux
git clone https://github.com/DevinJP/VistronixWinter2017.git InternWinter2017
```

#### Load First VM 
unzip the virtual machine from the repository
```linux
mkdir UbuntuVM
unzip Ubuntu.zip -d UbuntuVM
```

#### Configure the Networks 
Bridge the network connection from the vm to the machine

#### Load Nested VM
Launch the nested vm from VMPlayer inside the first VM

#### Configure Server-side Settings
Edit the files for host, port, and user settings

##### Server Code

index.html - lines 3 & 4 of the JS script element change them to the comms and server IPs respectively
```javascript
var dir = new URL("http://0.0.0.0:8080/");
var serverDir = new URL("http://0.0.0.0:8080/");
```
checkAppVM.py - line 6 change **appIP** to AppVM's IP Address
```python
appIP = "0.0.0.0"
```
checkAppVM.py - line 9-11 change to the the CommsVM's IP and user info
```python
clientIP = '0.0.0.0'
clientUser = 'root'
clientPass = 'password'
```
initComms.py - line 3 change **command** to the path of the .vmx file to run (don't forget nogui at the end)
```python
command = "vmrun start /home/user/path/to/Ubuntu.vmx nogui"
```
killComms.py - line 3 do the same as above
```python
command = "vmrun stop /home/user/path/to/Ubuntu.vmx"
```
initComms.py & killComms.py - lines 5-7 change to Dom0's IP and user info
```python
clientIP = '0.0.0.0'
clientUser = 'root'
clientPass = 'password'
```

##### Comms VM Code

init.py - line 6-8 change to AppVM's IP and user info
killradios.py - line 6-8 follow same steps as for init.py
```python
clientIP = '0.0.0.0'
clientUser = 'root'
clientPass = 'password'
```
rest.rb - line 7 change the **bind** address to the commsVM's IP Address
rest.rb - line 8 change the **port** number to the desired port (recommend changing from port 8080)
```ruby
set :bind, '0.0.0.0'
set :port, 8080
```
rest.rb - functions initApp() && killApp() change **command** after echo to the CommsVM's sudo password
```ruby
command = "echo password | sudo vmrun ...."
```
rest.rb - function checkApp() change **appIP** to AppVM's IP Address
```ruby
appIP = '0.0.0.0'
```

##### App VM Code

run.py - line 5 change **host** to the commsVM's IP Address and port
```python
host = "http://ipaddr:port/post"
```
syshealth.py - line 5 change **host** to commsVM's IP Address and port
```python
host = "http://ipaddr:port/post-health"
```

#### Run Server
Command to start server
```linux
ruby rest.rb
```

#### Launch Web Browser to view Client

## Behind the Scenes

### Front End Application
The loaded nested VM contains the front end for this project. When the applications are started, by the "radio.sh" script, 16 instances of a python script are run, run.py. This script constantly uses FFmpeg to generate .wav files at different frequencies and then POSTs those files to the server - these files are named <freq>done.wav. These python scripts represent 16 different radio applications which are distinguished by the different frequencies they play. The other applicable script is the linuxhealthcheck.sh script which writes the outputs of some CPU information linux commands to the file "linuxhealthcheck.sh". Script courtesy of: http://linoxide.com/linux-shell-script/shell-script-check-linux-system-health/

### Back End Application
First VM - The First VM hosts the server that is incharge of communication between the back end user interface and the front end application or a "Comms VM". The server is a ruby rest server that supports GET and POST requests. When a button is clicked on the user interface, a GET request is triggered on the server for the specified frequency. The server runs "init.py" which uses python Paramiko to kill all of the running instances then start the radio.sh script on the front end application. It also runs executehealth.py which runs the health check script mentioned above. Once the commands have been executed, the server fulfills the GET request by sending the resulting .wav and .txt file of the radio and health scripts. The server also listens for POST requests from the front end application which is mentioned above. 

User Interface - The user interface is the HTML page "index.html" which is contained in the "~/sinatra/public" directory in the first VM. The HTML page triggers the GET request that was mentioned in the previous section. Upon recieving the .wav and .txt files, the HTML will play the audio contained in the .wav and display the text in the .txt files dynamically on the page. The audio will be played on a loop as the page will send a new GET request when the audio player gets to the end of the .wav file. The page also uses a canvas graph to show the user a visual of the wave everytime a new GET request is sent; however users will only see a difference in the drawing when a new frequency is selected. Visualizer courtesy of: http://js.do/blog/sound-waves-with-javascript/
