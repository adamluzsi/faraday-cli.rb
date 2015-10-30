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

      when !(file_paths = fetch_file_paths(Dir.pwd)).empty?
        file_paths

      when !(file_paths = fetch_file_paths_from_folder(Dir.pwd)).empty?
        file_paths

      when !(file_paths = fetch_file_paths(PWD.pwd)).empty?
        file_paths

      when !(file_paths = fetch_file_paths_from_folder(PWD.pwd)).empty?
        file_paths

      when !(file_paths = fetch_file_paths(ENV['HOME'])).empty?
        file_paths

      when !(file_paths = fetch_file_paths_from_folder(ENV['HOME'])).empty?
        file_paths

      else
        []

    end
  end

  private

  def fetch_file_paths_from_folder(*from_folder)
    select_file_paths(Dir.glob(File.join(*from_folder,NAME_PATH_MATCHER, '*.{rb,ru}')))
  end

  def fetch_file_paths(*from_folder)
    select_file_paths(Dir.glob(File.join(*from_folder, NAME_PATH_MATCHER)))
  end

  def select_file_paths(file_paths)
    file_paths.select { |path| File.exists?(path) and not File.directory?(path)  }
  end

end