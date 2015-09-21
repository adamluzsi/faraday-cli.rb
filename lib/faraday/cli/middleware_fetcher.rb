require 'pwd'
module Faraday::CLI::MiddlewareFetcher
  extend self

  require 'faraday/cli/middleware_fetcher/container'

  def extend!(faraday_connection_builder, *config_file_paths)
    container = Faraday::CLI::MiddlewareFetcher::Container.new(faraday_connection_builder)
    get_file_paths(config_file_paths).each { |file_path| container.merge!(file_path) }
  end

  protected

  def get_file_paths(config_file_paths)
    file_name = '{.faraday.rb,.faraday}'
    case

      when !config_file_paths.empty?
        config_file_paths

      when !(file_paths = Dir.glob(File.join(Dir.pwd, file_name))).empty?
        file_paths

      when !(file_paths = Dir.glob(File.join(PWD.pwd, file_name))).empty?
        file_paths

      when !(file_paths = Dir.glob(File.join(ENV['HOME'], file_name))).empty?
        file_paths

      else
        []

    end
  end

end