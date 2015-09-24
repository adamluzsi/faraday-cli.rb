module Faraday::CLI::Option::Validator
  extend self

  ALLOWED_HTTP_METHODS = %w(get head post put patch delete options)

  def validate(argv,options_hash)
    validate_url(argv[0])
    validate_http_method(options_hash)
  end


  protected

  def validate_url(url_str)
    if url_str.nil? || url_str == ''
      $stderr.puts('Missing URL to make request!')
      exit(1)
    end
  end

  def validate_http_method(options_hash)
    unless ALLOWED_HTTP_METHODS.include?(options_hash[:http_method])
      $stderr.puts("invalid http method given: #{options_hash[:http_method].inspect}")
      exit(1)
    end
  end

end