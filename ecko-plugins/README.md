~~~~# Ecko::Plugins

The gem serves the purpose of being a registry for multiple plugins within the mastodon ecosystem.

# Releases
https://github.com/magicstone-dev/ecko-plugins/releases

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ecko-plugins'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ecko-plugins

## Development

The gem only helps in registering the plugin which has it own engine and runs through it. Currently it will only
but in future, there will be structural validatios for the plugins that registers to this resgistry.

How to develop a plugin which registers to this registry?

We can develop the plugin as a gem or as an internal service as well.

Ecko::Plugins.register(name: <plugin name>, schema: <plugin schema>, engine: <plugin Engine: This needs to be a class>)
name of the plugin needs to be a snake case (foo_bar).
schema: Schema is a hash/object which will help the plugin stucture and will set some default configurations.
engine: Engine is a ruby class which should at least expose a class defination known as configure.

```ruby
module Ecko
  module Plugins
    module Example
      class Engine
        class << self
          def configure(schema)
            Do something in this engine with the schema
            This all depends on how you want to handle this engine
          end
        end
      end
    end
  end
end

```

With this, lets say we register a plugin with the name 'example'
Then the engine is exposed as Ecko::Plugins.example to make it easier for devs to use the plugin.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Contributing

We're following a protocol called the Collective Code Construction Contract (C4) that says if you are addressing a valid problem, your code gets merged. Everything else follows from that.
Bug reports and pull requests are welcome on GitHub at https://github.com/magicstone-dev/ecko-plugins. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [GPL/AGPL License](https://opensource.org/licenses/GPL/AGPL).
