# VistronixWinter2017

## Getting Started

#### Install VMWare
Install VMWare Workstation Player [here](http://www.vmware.com/products/player/playerpro-evaluation.html)

#### Load First VM 
Download the image from the repository


#### Configure the Networks 
Bridge the network connection from the vm to the machine

#### Load Nested VM
Launch the nested vm from VMPlayer inside the first VM

#### Configure Server-side Settings
Edit the files for host and port and prefered settings
 
index.html - line 281 change "10.19.100.161" to the IP of the first VM on your network.

rest.rb - line 7 change "10.19.100.161" to the IP of the first VM on your network
 
executehealth.py - line 9 change "10.19.100.161" to the IP of the first VM on your network
                   line 12 change "192.168.110.131" to the IP of the nested VM on your network
                  
killradios.py - line 6 change "192.168.110.131" to the IP of the nested VM on your network


#### Run Server
Command to start server
```linux
ruby -Ilib rest.rb
```

#### Launch Web Browser to view Client

## Behind the Scenes

### Front End Application
The loaded nested VM contains the front end for this project. When the applications are started, by the "radio.sh" script, 16 instances of a python script are run, run.py. This script constantly uses FFmpeg to generate .wav files at different frequencies and then POSTs those files to the server - these files are named <freq>done.wav. These python scripts represent 16 different radio applications which are distinguished by the different frequencies they play. The other applicable script is the linuxhealthcheck.sh script which writes the outputs of some CPU information linux commands to the file "health-debian.sh". Script courtesy of: http://linoxide.com/linux-shell-script/shell-script-check-linux-system-health/

### Back End Application
First VM - The First VM hosts the server that is incharge of communication between the back end user interface and the front end application or a "Comms VM". The server is a ruby rest server that supports GET and POST requests. When a button is clicked on the user interface, a GET request is triggered on the server for the specified frequency. The server runs "init.py" which uses python Paramiko to kill all of the running instances then start the radio.sh script on the front end application. It also runs executehealth.py which runs the health check script mentioned above. Once the commands have been executed, the server fulfills the GET request by sending the resulting .wav and .txt file of the radio and health scripts. The server also listens for POST requests from the front end application which is mentioned above. 

User Interface - The user interface is the HTML page "index.html" which is contained in the "~/sinatra/public" directory in the first VM. The HTML page triggers the GET request that was mentioned in the previous section. Upon recieving the .wav and .txt files, the HTML will play the audio contained in the .wav and display the text in the .txt files dynamically on the page. The audio will be played on a loop as the page will send a new GET request when the audio player gets to the end of the .wav file. The page also uses a canvas graph to show the user a visual of the wave everytime a new GET request is sent; however users will only see a difference in the drawing when a new frequency is selected. Visualizer courtesy of: http://js.do/blog/sound-waves-with-javascript/
