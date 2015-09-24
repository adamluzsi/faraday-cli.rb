class Faraday::CLI::Middleware::VerboseResponse < Faraday::Middleware

  def call(request_env)
    @app.call(request_env).on_complete do |src_response_env|
      response_env = src_response_env.dup
      response_env.delete(:body)

      $stdout.puts(YAML.dump({'response' => response_env}),"\n")
    end
  end

end