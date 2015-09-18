require 'forwardable'
class Faraday::CLI::MiddlewareFetcher::Container

  extend Forwardable
  def_delegator :@builder, :use

  def initialize(conn)
    @builder = conn.builder
  end

  def merge!(file_path)
    instance_eval(File.read(file_path))
  end

end
