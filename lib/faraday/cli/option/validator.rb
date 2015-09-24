module Faraday::CLI::Option::Validator
  extend self

  ALLOWED_HTTP_METHODS = %w(get head post put patch delete options)

  def validate(options_hash)
    validate_http_method(options_hash)
  end

  protected

  def validate_http_method(options_hash)
    unless ALLOWED_HTTP_METHODS.include?(options_hash[:http_method])
      $stderr.puts("invalid http method given: #{options_hash[:http_method].inspect}")
      exit(1)
    end
  end

end