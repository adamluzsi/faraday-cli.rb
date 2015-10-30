require 'optparse'
class Faraday::CLI::Option::Parser

  def parse!
    options = {}
    merge_defaults(options)
    OptionParser.new do |o|

      o.banner.concat(' <url>')

      o.on('-V', '--version', 'Show version number and quit') { $stdout.puts(Faraday::CLI::VERSION); exit }

      o.on('-X', '--request COMMAND', 'Specify http request command to use') do |http_method|
        options[:http_method]= http_method.to_s.strip.downcase
      end

      o.on('-H', '--header HEADER:VALUE', 'Pass custom header LINE to server (H)') do |header|
        options[:http_headers].push(header.split(/:\s*/))
      end

      o.on('-q', '--query key=value', 'Pass Query key values to use in the request') do |raw_query_pair|
        separator = '='

        parts = raw_query_pair.split(separator)
        query_key = parts.shift
        query_value = parts.join(separator)

        options[:params].push([query_key,query_value])
      end

      o.on('-d', '--data PAYLOAD_STRING', 'HTTP POST data (H)') { |payload| options[:body]= payload }

      o.on('--upload_file KEY=FILE_PATH[:CONTENT_TYPE]', 'Pass File upload io in the request pointing to the given file') do |payload_file_path|

        options[:flags] << :multipart

        parts = payload_file_path.split('=')
        raw_file_path = parts.pop
        key = parts.first

        file_path, content_type = raw_file_path.split(':')
        content_type ||= 'application/octet-stream'

        file_stream_io = Faraday::UploadIO.new(File.realpath(file_path), content_type)

        options[:body] = {key => file_stream_io}

      end

      o.on('-A', '--user-agent STRING', 'Send User-Agent STRING to server (H)') do |user_agent|
        options[:http_headers] << ['User-Agent', user_agent]
      end

      o.on('-o', '--output FILE_PATH', 'Write to FILE instead of stdout') do |out_file_path|
        $stdout.reopen(out_file_path, 'a+')
        $stderr.reopen(out_file_path, 'a+')
      end

      # o.on('-x', '--proxy HOST:PORT', 'HOST[:PORT] Use proxy on given port') do |host_port_str|
      #   host, port = host_port_str.split(':')
      #   port = '80' if port.nil?
      #
      #   options[:proxy]= {host: host, port: port}
      # end

      o.on('-v', '--verbose', 'Make the operation more talkative') do
        options[:flags] << :verbose
      end

      o.on('--super-verbose', 'Make the operation even more talkative') do
        options[:flags] << :super_verbose
      end

      o.on('-s', '--silent', "Silent mode (don't output anything)") do
        options[:flags] << :silent
        $stdout.reopen('/dev/null', 'a+')
        $stderr.reopen('/dev/null', 'a+')
      end

      o.on('-K', '--config FILE_PATH', 'File path to the .faraday.rb if you want use other than default') do |file_path|
        options[:config_file_paths] << File.absolute_path(file_path)
      end

      o.on('-M', '--middlewares', 'Show current middleware stack') do
        options[:flags] << :show_middlewares
      end

      o.on('-W', '--without_middlewares', 'Make request without consuming middleware file(s)') do
        options[:flags] << :without_middlewares
      end

      # Z

      o.parse!

    end

    options
  end

  protected

  def merge_defaults(hash)
    hash[:flags]= []
    hash[:params]= []
    hash[:http_method]= 'get'
    hash[:http_headers]= []
    hash[:config_file_paths]= []
    hash
  end

end