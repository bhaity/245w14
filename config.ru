require './myapp'
require File.expand_path '../myapp.rb', __FILE__

run Rack::URLMap.new({
  "/" => Public,
  "/protected" => Protected
})

#run Sinatra::Application