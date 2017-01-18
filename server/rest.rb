require 'sinatra'
require 'sinatra/json'
require 'net/http'
require 'bundler'

Bundler.require

set :bind, '0.0.0.0'
set :port, 8080

get '/' do
	"Hey this is our project, type in '/index' in the address bar for our branch 0 working app!\n"
end

get '/index' do
	headers 'Access-Control-Allow-Origin' => '*'
	send_file File.join(settings.public_folder, "index.html")
	status 200
end

get '/dom0' do 
	statusDom0 = checkDom0()
	if statusDom0.to_i == 0 #available
		status 200	
	elsif statusDom0.to_i == 1
		status 409
	else
		status 666
	end
end

get '/comms' do
	statusComms = checkComms()
	if statusComms.to_i == 0 #available
		status 200
	elsif statusComms.to_i == 1  #not available
		status 409
	else
		status 666
	end
end

get '/app' do
	statusApp = checkApp()
	if statusApp.to_i == 200 # Available
		status 200
	elsif statusApp.to_i == 409  #not available
		status 409
	else
		status 666	
	end
end

get '/start-comms' do
	startComms()
	status 200
end

get '/kill-comms' do
	killComms()
	status 200
end

def checkDom0()
	domIP = "0.0.0.0"
	command = "nc -w 3 -z " + domIP + " 22 > /dev/null ; echo $?"
	statusDom0 = %x(#{command})
end

def checkComms()
	commsIP = "0.0.0.0"
        command = "nc -w 3 -z " + commsIP + " 22 > /dev/null ; echo $?"
        statusComms = %x(#{command})
end

def checkApp()
	url = URI.parse('http://10.19.100.161:8080/app')
	req = Net::HTTP::Get.new(url.to_s)
	res = Net::HTTP.start(url.host, url.port, :read_timeout => 5) {|http|
		http.request(req)
	}
	#puts res.body
	res.code
end

def startComms
	command = "python initComms.py"
	%x(#{command})
end

def killComms
	command = "python killComms.py"
        %x(#{command})
end
