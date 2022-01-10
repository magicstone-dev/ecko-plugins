# frozen_string_literal: true

module Ecko
  module Plugins
    module Stripe
      class Configurations
        include Singleton
        attr_accessor :schema

        def setup(schema)
          @schema = schema
        end

        # Stripe API key configured through schema
        def stripe_api_key
          schema[:stripe_api_key]
        end

        # The state secret is used if we have to encrypt any state on callbacks
        # Currently this hasn't been used.
        def state_secret
          schema[:state_secret]
        end

        # Configured currency while checkout process.
        def currency
          schema[:currency] || 'USD'
        end

        # Callback url which helps in returning to the correct url when a payment is complete or
        # cancelled
        def callback
          schema[:callback]
        end
      end
    end
  end
end
