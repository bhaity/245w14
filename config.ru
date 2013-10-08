require 'rack_mailer'
# require './myapp'
# run Sinatra::Application

use Rack::Static, 
  :urls => ["/images", "/javascripts", "/stylesheets"],
  :root => "public"

map "/" do
  run lambda { |env|
  [
    200, 
    {
      'Content-Type'  => 'text/html', 
      'Cache-Control' => 'public, max-age=86400' 
    },
    File.open('public/index.html', File::RDONLY)
  ]
}
end

map '/mail_to' do
    run Rack::Mailer.new {
  to 'bhaity@gmail.com'
  from 'sikandar.shukla@gmail.com'
  subject 'New Enquiry - Village Green West'
  body ''

  }
end


map "/mobile" do
  run lambda { |env|
  [
    200, 
    {
      'Content-Type'  => 'text/html', 
      'Cache-Control' => 'public, max-age=86400' 
    },
    File.open('public/mobile.html', File::RDONLY)
  ]
}
end


map "/home" do
  run lambda { |env|
  [
    200, 
    {
      'Content-Type'  => 'text/html', 
      'Cache-Control' => 'public, max-age=86400' 
    },
    File.open('public/desktop.html', File::RDONLY)
  ]
}
end

Mail.defaults do
  delivery_method :smtp, { :address   => "smtp.gmail.com",
                           :port      => 587,
                           :domain    => "yourdomain.com",
                           :user_name => "village.green.west.mailer@gmail.com",
                           :password  => "245w14st",
                           :authentication => 'plain',
                           :enable_starttls_auto => true }
end