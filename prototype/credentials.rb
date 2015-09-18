require 'escher-keypool'

ENV['KEY_POOL'] = '[{"keyId":"EscherExample","secret":"TheBeginningOfABeautifulFriendship","acceptOnly":0}]'
ENV['ESCHEREXAMPLE_KEYID'] = 'EscherExample'

CredentialScope = 'example/credential/scope'
AuthOptions = {}
ESCHER_KEY = {api_key_id: 'EscherExample', api_secret: 'TheBeginningOfABeautifulFriendship'}

class ECHO

  def initialize(app)
    @app = app
  end

  def call(env)
    puts YAML.dump env
    @app.call(env)
  end

end