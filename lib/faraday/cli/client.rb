class Faraday::CLI::Client

  def self.start(argv)
    new(argv).start
  end

  def start

    cli_options = Faraday::CLI::Option::Parser.new.parse!
    Faraday::CLI::Option::Validator.validate(@argv,cli_options)

    connection = Faraday.new do |builder|
      builder.use Faraday::Response::RaiseError

      unless cli_options[:flags].include?(:without_middlewares)
        Faraday::CLI::MiddlewareFetcher.extend!(builder, *cli_options[:config_file_paths])
      end

      builder.request(:multipart) if cli_options[:flags].include?(:multipart)

      if cli_options[:flags].include?(:verbose)
        builder.response :logger
      end

      if cli_options[:flags].include?(:super_verbose)
        builder.use Faraday::CLI::Middleware::VerboseRequest
        builder.use Faraday::CLI::Middleware::VerboseResponse
      end

      builder.adapter(Faraday.default_adapter)
    end

    if cli_options[:flags].include?(:show_middlewares)
      $stdout.puts(connection.builder.handlers.map(&:inspect))
      exit
    end

    Faraday::CLI.active_connection = connection.dup

    begin

      response = connection.public_send(cli_options[:http_method].downcase) do |request|

        request.url(@argv[0])

        cli_options[:http_headers].each do |key, value|
          request.headers[key]=value
        end

        cli_options[:params].each do |key, value|
          request.params[key]=value
        end

        request.body = cli_options[:body] unless cli_options[:body].nil?

      end

      $stdout.puts(response.body)

    rescue Faraday::ClientError => ex
      $stdout.puts(ex.message)
      $stdout.puts(ex.response[:body]) unless ex.response.nil?
      exit(1)

    rescue URI::InvalidURIError => ex
      $stdout.puts(ex.message)
      exit(1)

    end
    
  end

  protected

  def initialize(argv)
    @argv = argv
  end

end
