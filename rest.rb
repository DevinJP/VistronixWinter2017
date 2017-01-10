require 'sinatra'
require 'sinatra/json'
require 'bundler'

Bundler.require

set :bind, '10.19.100.161'
set :port, 8080

get '/' do
	"Hey this is our project, type in 'index' in the address bar for our app!\n"
end

get '/index' do
	headers 'Access-Control-Allow-Origin' => '*'
	send_file File.join(settings.public_folder, "index.html")
	status 200
end

get '/health-debian' do
	headers 'Access-Control-Allow-Origin' => '*'
	run_sys_health()
	send_file File.join(settings.public_folder, "health-debian.txt")
	status 200
end

get '/start' do
	init()
	status 200
end

get '/kill' do
	kill()
	status 200
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

get '/600' do
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

def run_sys_health()
	command = "python executehealth.py"
	%x(#{command})
end

def init()
	command = "python init.py"
	%x(#{command})
end

def kill()
        command = "python killradios.py"
        %x(#{command})
end

post '/post' do
	if params[:wav] && params[:wav][:filename]
   		filename = params[:wav][:filename]
		file = params[:wav][:tempfile]
		path = "./public/#{filename}"

		# Write file to disk
		File.open(path, 'wb') do |f|
			f.write(file.read)
		end
	end
	status 200
end
