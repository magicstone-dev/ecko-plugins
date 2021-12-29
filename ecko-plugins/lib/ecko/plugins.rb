require "ecko/plugins/version"
require 'rails'

module Ecko
  module Plugins
    class Error < StandardError; end

    class PluginPresentError < StandardError; end

    class Registry; end

    # Set a registry variable to help cache all the registries
    mattr_accessor :registry, default: {}

    class << self
      # Registers a new plugin, A plugin with the same name cannot be registered twice
      # That will raise Ecko::Plugins::PluginPresentError if a plugin is already registered.
      # name: Name of the plugin in snail case
      # schema: hash/object or any data structure which defines the plugin
      # engine: It is a class which exposes a configure class definition(method)
      def register(name:, schema:, engine:)
        raise Ecko::Plugins::PluginPresentError if Ecko::Plugins.registry[name].present?

        # This helps set a new reference class which will be used as a pristine class. It doesnt have a big
        # role currently but will serve a great deal of purpose in the future.
        registered_plugin = Ecko::Plugins::Registry.const_set(name.capitalize, Class.new(engine))
        Ecko::Plugins.registry[name] = { schema: schema, engine: engine, engine_stub: registered_plugin }
        register_method(name, registered_plugin)
        execute_pipeline(registered_plugin, schema)
      end

      # Pipeline just includes configuration currently, It will help us run a validation pipeline in the future.
      # TODO: Update the comment on the method when upgraded.
      def execute_pipeline(registered_plugin, schema)
        registered_plugin.configure(schema)
      end

      # Creates a singleton class to help devs use the plugin engine and run methods accordingly.
      def register_method(name, engine)
        define_singleton_method name do
          engine
        end
      end
    end
  end
end
