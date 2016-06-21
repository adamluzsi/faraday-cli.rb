require_relative 'credentials'

require 'yaml'
require 'rack'
require 'escher/rack_middleware'
Escher::RackMiddleware.config do |c|
  c.add_escher_authenticator { Escher::Auth.new(CredentialScope, AuthOptions) }
  c.add_credential_updater { Escher::Keypool.new.get_key_db }
end

class YourAwesomeApp
  def call(env)
    puts YAML.dump(env)
    puts_payload(env)

    response = Rack::Response.new
    response.write 'OK'
    response.status = 200

    response.finish
  end

  def puts_payload(env)
    payload = ''
    while chunk = env['rack.input'].gets
      payload.concat(chunk)
    end

    puts "payload:\n", payload
  end
end

use ECHO
use Escher::RackMiddleware
run YourAwesomeApp.new

# Rack::Server.start :app => YourAwesomeApp,
#                   :Port => ARGV[0].to_i
