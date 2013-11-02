#myapp.rb
require 'sinatra'
require 'nokogiri'
require 'pony'

Pony.options = {
  :from => 'info@villagegreenwest.com',
  :headers => { 'Content-Type' => 'text/html' },
  :via => :smtp,
  :via_options => {
    :address              => 'smtp.gmail.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :user_name            => 'info@villagegreenwest.com',
    :password             => '245west245',
    :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
    :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
  }
}

get '/' do
	# @doc = Nokogiri::XML(File.read("books.xml"))
 #  @books = @doc.xpath("//book")
 #  raise @books.inspect
  erb :index
end

get '/mobile' do
  erb :mobile
end

get '/home' do
  erb :desktop
end

post '/mail_to' do
  Pony.mail :subject => "Village Green West | New Inquiry Received",
            :body    => erb(:email),
            :to => params["Email Address"],
            :bcc => 'info@245w14.com'
end