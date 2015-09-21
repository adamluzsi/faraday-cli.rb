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
    folder_name = '{.faraday.rb,.faraday,.faraday-cli}'

    case

      when !config_file_paths.empty?
        config_file_paths.reduce([]) do |file_paths, given_path|
          file_paths.push(*Dir.glob(given_path)); file_paths
        end

      when !(file_paths = Dir.glob(File.join(Dir.pwd, file_name))).empty?
        file_paths

      when !(file_paths = folder_content(Dir.pwd, folder_name)).empty?
        file_paths

      when !(file_paths = Dir.glob(File.join(PWD.pwd, file_name))).empty?
        file_paths

      when !(file_paths = folder_content(PWD.pwd, folder_name)).empty?
        file_paths

      when !(file_paths = Dir.glob(File.join(ENV['HOME'], file_name))).empty?
        file_paths

      when !(file_paths = folder_content(ENV['HOME'], folder_name)).empty?
        file_paths

      else
        []

    end
  end


  protected

  def folder_content(main_path, folder_name)
    Dir.glob(File.join(main_path, folder_name, '*.rb')).select { |path| not File.directory?(path) }
  end

end