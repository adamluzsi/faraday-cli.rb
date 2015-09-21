# Faraday::Cli

Console line interface for faraday gem client so you can use your favorite middleware based ruby http client on the terminal!


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'faraday-cli'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install faraday-cli

## Usage

### CLI options

```shell
Usage: faraday-cli [options] <url>
    -V, --version                    Show version number and quit
    -X, --request COMMAND            Specify http request command to use
    -H, --header HEADER:VALUE        Pass custom header LINE to server (H)
    -q, --query key=value            Pass Query key values to use in the request
    -d, --data PAYLOAD_STRING        HTTP POST data (H)
        --upload_file KEY=FILE_PATH[:CONTENT_TYPE]
                                     Pass File upload io in the request pointing to the given file
    -A, --user-agent STRING          Send User-Agent STRING to server (H)
    -o, --output FILE_PATH           Write to FILE instead of stdout
    -s, --silent                     Silent mode (don't output anything)
    -c, --config FILE_PATH           File path to the .faraday.rb if you want use other than default
    -M, --middlewares                Show current middleware stack
    
faraday-cli http://www.google.com -q q=foo
faraday-cli http://example.org -d "payload string"
```

### Middleware use

You can use middlewares with ".faraday.rb" file. 
Put any middleware related configuration into the file,
and use the 'use' method to include into the faraday connection.

you can use any faraday middlewares as how you pleased.
 
```ruby

class MyAwesomeMiddleware

  def initialize(app)
    @app = app
  end

  def call(env)
    puts env.object_id
    @app.call(env)
  end

end

use MyAwesomeMiddleware

```

By default it will look for the current runtime directory for this file. 
If you are in a project, than it will look for the project folder (Ruby project).
If still nothing than for the last place to look it will check for Home folder to find a default middleware file.

With that you can use all kind of stuff out of the box with your faraday-cli, such as Amazon v3 authentication, or
 anything that is on the internet :D

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/faraday-cli. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

