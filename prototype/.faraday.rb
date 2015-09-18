require './credentials'

require 'faraday_middleware/escher'

use FaradayMiddleware::Escher::RequestSigner,
    credential_scope: CredentialScope,
    options: AuthOptions,
    active_key: -> { Escher::Keypool.new.get_active_key('EscherExample') }
