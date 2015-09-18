require 'pwd'
module Faraday::CLI::MiddlewareFetcher
  extend self

  require 'faraday/cli/middleware_fetcher/container'

  def extend!(faraday_connection)

    file_name = '.faraday.rb'
    container = Faraday::CLI::MiddlewareFetcher::Container.new(faraday_connection)

    case true

      when File.exist?(File.join(Dir.pwd, file_name))
        container.merge!(File.join(Dir.pwd, file_name))

      when File.exist?(File.join(PWD.pwd, file_name))
        container.merge!(File.join(PWD.pwd, file_name))

      when File.exist?(File.join(ENV['HOME'], file_name))
        container.merge!(File.join(ENV['HOME'], file_name))

      else
        nil

    end

  end

end