require 'cgi'
cgi = CGI.new
h = cgi.params
puts h['fname'] 