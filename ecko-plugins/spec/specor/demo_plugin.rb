# THis is a demo plugin module with its engine which will be registered in the registry
module DemoPlugin
  class Engine
    @@configured_dummy_value = nil

    class << self
      def configure(_schema)
        @@configured_dummy_value = 'Configured'
        'Registration for the plugin is complete'
      end

      def configured_data
        @@configured_dummy_value
      end
    end
  end
end
