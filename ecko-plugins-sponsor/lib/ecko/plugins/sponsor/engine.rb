# frozen_string_literal: true

require_relative 'configurations'
require_relative 'schema_validator'
require_relative 'process'

# This class is the engine of the sponsor plugin. IT doesnt do much but helps in
# redirecting process and configurations to different classes within the plugin.
# THis class is registered in the ecko plugins registry
module Ecko
  module Plugins
    module Sponsor
      class Engine
        class << self
          # THis is the main engine configurer that the registry uses. THe schema is passed here
          # and configured accordingly.
          def configure(schema)
            Ecko::Plugins::Sponsor::Configurations.instance.setup(schema)
          end

          # The gateways to be able to sponsor.
          def gateways
            Ecko::Plugins::Sponsor::Configurations.instance.gateways
          end

          # Processes the donation here.
          def process(package_id, account)
            Ecko::Plugins::Sponsor::Process.run(package_id, account)
          end
        end
      end
    end
  end
end
