require 'yaml'
class Faraday::CLI::Middleware::VerboseRequest < Faraday::Middleware

  def call(request_env)
    $stdout.puts(YAML.dump(request_env),"\n")

    @app.call(request_env)
  end

end