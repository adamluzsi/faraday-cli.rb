require 'faraday'
module Faraday::CLI

  class << self
    attr_accessor :active_connection
  end

  require 'faraday/cli/version'
  require 'faraday/cli/core_ext'

  require 'faraday/cli/client'
  require 'faraday/cli/option'
  require 'faraday/cli/middleware'
  require 'faraday/cli/middleware_fetcher'

end