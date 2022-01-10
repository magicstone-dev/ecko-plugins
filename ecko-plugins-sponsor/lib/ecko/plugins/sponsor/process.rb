# frozen_string_literal: true

require 'ecko/plugins/sponsor/parser/stripe'

# This class processes the gateway and parses the donation object. Currently only default option
# as a runner is provided but when adding multiple parsers in future, we will have a choice option when
# we add multiple gateways in the future.
module Ecko
  module Plugins
    module Sponsor
      class Process
        attr_accessor :package, :account

        # Get the donation package and set it here. If it is not found, RecordNotFound error
        # will be raised
        def initialize(package_id, account)
          # Find the package through which we can donate.
          @package = ::DonationPackage.find(package_id)

          # A sponsor should always be associated with an account
          @account = account
        end

        # This will run the gateway process based on the object set during configuration
        def run
          send("run_#{gateways[:run]}")
        end

        private

        # Currently we just have a stripe parser which will never run this process so it is an empty
        # runner currently.
        # TODO: Set this up when we have multiple parsers. It should not run gateway process but redirect to a choice of gateway
        def run_choice; end

        # When we have only a default processor, we just parse the gateway object
        # and then run the checkout flow for it.
        def run_default
          value = Object.const_get("Ecko::Plugins::Sponsor::Parser::#{gateways[:default][:name]}").build(package, account)
          gateways[:default][:checkout].execute(value)
        end

        # Gets all the gateways that was registered for this plugin.
        def gateways
          @gateways ||= Ecko::Plugins::Sponsor::Configurations.instance.gateways
        end

        class << self
          def run(package_id, account)
            new(package_id, account).run
          end
        end
      end
    end
  end
end
