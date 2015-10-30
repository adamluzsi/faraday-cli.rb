module Faraday::CLI::Option::Validator
  extend self

  ALLOWED_HTTP_METHODS = %w(get head post put patch delete options)

  def validate(argv,options_hash)
    validate_url(argv[0])
    validate_http_method(options_hash)
    validate_http_headers(options_hash)
  end

  def validate_http_headers(options_hash)
    alert('header is in malformed format!') if options_hash[:http_headers].any?{|pairs| pairs.length != 2  }
  end

  protected

  def validate_url(url_str)
    alert('Missing URL to make request!') if url_str.nil? || url_str == ''
  end

  def validate_http_method(options_hash)
    unless ALLOWED_HTTP_METHODS.include?(options_hash[:http_method])
      alert("invalid http method given: #{options_hash[:http_method].inspect}")
    end
  end

  private

  def alert(message)
    $stderr.puts(message)
    exit(1)
  end

end