# frozen_string_literal: true
require 'ecko/plugins/stripe/configurations'
require 'ecko/plugins/stripe/authenticator'
require 'ecko/plugins/stripe/checkout'

module Ecko
  module Plugins
    module Stripe
      class Engine
        class << self
          # Configures all the schema and setups the configurations instance of the plugin
          def configure(schema)
            Ecko::Plugins::Stripe::Configurations.instance.setup(schema)
          end

          # It helps authenticate the stripe plugin api key.
          def authenticate
            ::Stripe.api_key = Ecko::Plugins::Stripe::Configurations.instance.stripe_api_key
          end

          # This will provide the checkout reference for other plugins as well
          # Currently ecko sponsor plugin uses this.
          def checkout_reference
            Ecko::Plugins::Stripe::Checkout
          end

          # Creates a checkout session with a payment intent as well.
          def checkout(params)
            checkout_reference.execute(params)
          end
        end
      end
    end
  end
end
