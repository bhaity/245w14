#myapp.rb
require 'sinatra'

get '/' do
  send_file 'public/index.html'
end

get '/mobile' do
  send_file 'public/mobile.html'
end

get '/home' do
  send_file 'public/desktop.html'
end