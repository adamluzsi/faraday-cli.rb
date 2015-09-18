require 'yaml'
module Faraday::CLI::ResponseFormatter
  extend self

  def format(faraday_response)
    formatted_message_parts = []
    formatted_message_parts << YAML.dump(response_hash_by(faraday_response))
    formatted_message_parts << faraday_response.body

    formatted_message_parts.join("\n")
  end

  protected

  def response_hash_by(faraday_response)
    {
        'response' => {
            'status' => faraday_response.status,
            'headers' => Hash[faraday_response.headers]
        }
    }
  end

end
