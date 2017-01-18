require 'sinatra'
require 'sinatra/json'
require 'bundler'

Bundler.require

set :bind, '10.19.100.219'
set :port, 8080

before do
	cache_control :public, :no_cache
	headers 'Access-Control-Allow-Origin' => '*'
end

get '/health-kali' do
	send_file File.join(settings.public_folder, "health-kali.txt")
	status 200
end

get '/start' do
        headers 'Access-Control-Allow-Headers' => "accept, authorization, origin"
	startRadios()
	status 200
end

get '/kill' do
        headers 'Access-Control-Allow-Headers' => "accept, authorization, origin"
        killRadios()
        status 200
end


get '/start-app' do
        headers 'Access-Control-Allow-Headers' => "accept, authorization, origin"
	initApp()
	status 200
end

get '/kill-app' do
        headers 'Access-Control-Allow-Headers' => "accept, authorization, origin"
	killApp()
	status 200
end

get '/app' do
	headers 'Access-Control-Allow-Headers' => "accept, authorization, origin"
	statusApp = checkApp()
	if statusApp.to_i == 0 # Available
		status 200
	elsif statusApp.to_i == 1  #not available
		status 409
	else
		status 666	
	end
end

get '/100' do
	send_file File.join(settings.public_folder, "100done.wav")
	status 200
end

get '/200' do
        send_file File.join(settings.public_folder, "200done.wav")
        status 200
end

get '/301' do
        send_file File.join(settings.public_folder, "300done.wav")
        status 200
end

get '/401' do
        send_file File.join(settings.public_folder, "400done.wav")
        status 200
end

get '/500' do
        send_file File.join(settings.public_folder, "500done.wav")
        status 200
end

get '/601' do
        send_file File.join(settings.public_folder, "600done.wav")
        status 200
end

get '/700' do
        send_file File.join(settings.public_folder, "700done.wav")
        status 200
end

get '/800' do
        send_file File.join(settings.public_folder, "800done.wav")
        status 200
end

get '/900' do
        send_file File.join(settings.public_folder, "900done.wav")
        status 200
end

get '/1000' do
        send_file File.join(settings.public_folder, "1000done.wav")
        status 200
end

get '/1100' do
        send_file File.join(settings.public_folder, "1100done.wav")
        status 200
end

get '/1200' do
        send_file File.join(settings.public_folder, "1200done.wav")
        status 200
end

get '/1300' do
        send_file File.join(settings.public_folder, "1300done.wav")
        status 200
end

get '/1400' do
        send_file File.join(settings.public_folder, "1400done.wav")
        status 200
end

get '/1500' do
        send_file File.join(settings.public_folder, "1500done.wav")
        status 200
end

get '/1600' do
        send_file File.join(settings.public_folder, "1600done.wav")
        status 200
end

def startRadios()
	command = "python init.py"
        %x(#{command})
end

def killRadios()
        command = "python killradios.py"
        %x(#{command})
end

def initApp()
	command = "echo password | sudo vmrun start /home/comms/vmware/Ubuntu/Ubuntu.vmx nogui"
	%x(#{command})
end

def killApp()
	command = "echo password | sudo vmrun stop /home/comms/vmware/Ubuntu/Ubuntu.vmx"
        %x(#{command})
end

def checkApp()
	appIP = '0.0.0.0'
	command = "nc -w 2 -z " + appIP + " 22 > /dev/null ; echo $?"	
	statusApp = %x(#{command})	
end

post '/post' do
	if params[:wav] && params[:wav][:filename]
   		filename = params[:wav][:filename]
		file = params[:wav][:tempfile]
		path = "public/#{filename}"

		# Write file to public directory
		File.open(path, 'wb+') do |f|
			f.write(file.read)
		end
	end
	status 200
end

post '/post-health' do
	if params[:txt] && params[:txt][:filename]
		filename = params[:txt][:filename]
		file = params[:txt][:tempfile]
		path = "public/#{filename}"

		#write file to public directory
		File.open(path, 'wb+') do |f|
			f.write(file.read)
		end
	end
	status 200
end
