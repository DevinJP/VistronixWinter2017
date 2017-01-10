import os
import sys
import time

host = "http://10.19.100.161:8080/post/"
freq = str(sys.argv[1])
runCommand = command = 'ffmpeg -f lavfi -i "sine=frequency='+freq+':sample_rate=8000:duration=3\" '+freq+'done.wav -loglevel quiet -y'
command = 'curl -X POST -F "wav=@'+freq+'done.wav" 10.19.100.161:8080/post'
while 1:
        os.system(runCommand)
        os.system(command)
        time.sleep(3)

