require 'pwd'
module Faraday::CLI::MiddlewareFetcher
  extend self

  NAME_PATH_MATCHER = '{.faraday,.faraday.rb,.faraday-cli}'

  require 'faraday/cli/middleware_fetcher/container'

  def extend!(faraday_connection_builder, *config_file_paths)
    container = Faraday::CLI::MiddlewareFetcher::Container.new(faraday_connection_builder)
    get_file_paths(config_file_paths).each { |file_path| container.merge!(file_path) }
  end

  protected

  def get_file_paths(config_file_paths)
    case

      when !config_file_paths.empty?
        config_file_paths.reduce([]) do |file_paths, given_path|
          if File.directory?(given_path)
            given_path = File.join(given_path,'*.rb')
          end

          file_paths.push(*Dir.glob(given_path)); file_paths
        end

      when !(file_paths = Dir.glob(File.join(Dir.pwd, NAME_PATH_MATCHER))).empty?
        file_paths

      when !(file_paths = folder_content(Dir.pwd, NAME_PATH_MATCHER)).empty?
        file_paths

      when !(file_paths = Dir.glob(File.join(PWD.pwd, NAME_PATH_MATCHER))).empty?
        file_paths

      when !(file_paths = folder_content(PWD.pwd, NAME_PATH_MATCHER)).empty?
        file_paths

      when !(file_paths = Dir.glob(File.join(ENV['HOME'], NAME_PATH_MATCHER))).empty?
        file_paths

      when !(file_paths = folder_content(ENV['HOME'], NAME_PATH_MATCHER)).empty?
        file_paths

      else
        []

    end
  end


  protected

  def folder_content(main_path, file_name)
    Dir.glob(File.join(main_path, file_name, '*.rb')).select { |path| not File.directory?(path) }
  end

end