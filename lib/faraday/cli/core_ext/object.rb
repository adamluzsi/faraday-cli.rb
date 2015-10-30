module Faraday::CLI::CoreExt::Object

  def active_connection
    ::Faraday::CLI.active_connection
  end

end

Object.__send__(:include,Faraday::CLI::CoreExt::Object)