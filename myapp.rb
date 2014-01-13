#myapp.rb
require 'sinatra/base'
require 'nokogiri'
require 'pony'
require 'csv'

class Public < Sinatra::Base

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
              :bcc => 'info@villagegreenwest.com'

    CSV.open('245registrations.csv', 'a+') do |csv|
      if params["Is A Broker"] then broker = 'yes' else broker = 'no' end
      if params["Represented By A Broker"] then rep_broker = 'yes' else rep_broker = 'no' end
      csv << [
              params["First Name"],
              params["Last Name"],
              params["Email Address"],
              params["Phone Number"], 
              params["Address"],
              params["City"],   
              params["State"],   
              params["Country"],  
              params["Residence"],
              params["Price Range"], 
              params["Heard About Us Through"],  
              params["Most Important Factor"], 
              params["Comments"],  
              broker,  
              rep_broker
              ]
    end
    return 'ok'
  end
end

class Protected < Sinatra::Base
  use Rack::Auth::Basic, "Enter credentials to access the CSV file." do |username, password|
    username == 'alfa' && password == 'alfamgmt1'
  end
  get '/csv' do
    send_file("245registrations.csv")
  end
end