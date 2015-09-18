require 'forwardable'
class Faraday::CLI::MiddlewareFetcher::Container

  #TODO: remove support for adapter set
  extend Forwardable
  def_delegators :@builder, :use, :request, :response, :adapter

  def initialize(builder)
    @builder = builder
  end

  def merge!(file_path)
    Dir.chdir(File.dirname(file_path)) do
      instance_eval(File.read(file_path))
    end
  end

end
