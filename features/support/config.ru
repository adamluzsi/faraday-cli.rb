rack_app_lib_folder = File.join(File.dirname(__FILE__), '..', '..','..', 'rack-app.rb', 'lib')
$LOAD_PATH.unshift(rack_app_lib_folder)
require 'rack/app'

require 'yaml'
class TestServer < Rack::App


  get '/params' do
    YAML.dump(params)
  end

  get '/' do |re|
    'hello world'
  end

  get '/nope' do
    response.write('no!')
  end

end

run TestServer