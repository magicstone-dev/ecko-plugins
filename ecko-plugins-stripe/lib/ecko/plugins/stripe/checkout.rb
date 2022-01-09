# frozen_string_literal: true

module Ecko
  module Plugins
    module Stripe
      class Checkout < Authenticator
        def run
          session.url
        end

        # Creates a session based on the parameters send
        def session
          @session ||= ::Stripe::Checkout::Session.create(
            payment_method_types: payment_method_types,
            mode: 'payment',
            submit_type: params[:submit_type] || 'pay',
            client_reference_id: SecureRandom.uuid,
            success_url: success_url,
            cancel_url: cancel_url,
            line_items: line_items
          )
        end

        private

        # Currently we only provide card payments, We can implment multiple types when required.
        def payment_method_types
          params[:types] || ['card']
        end

        # Creates a valid line item structure to pass it to the stipe checkout process.
        def line_items
          raise Ecko::Plugins::Stripe::InvalidLineItemError unless valid_line_items?

          params[:line_items].map do |line_item|
            # Amount ot be transferred
            amount = line_item[:amount].to_i

            # Raise invalid amount error if the amount is 0
            raise Ecko::Plugins::Stripe::InvalidAmountError if amount.zero?

            # Quantity of the item, normally its 1.
            quantity = line_item[:quantity].to_i

            # If Quantity is 0, then it doesnt let us go thorough by raising this error.
            raise Ecko::Plugins::Stripe::InvalidQuantityError if quantity.zero?

            # If Name is nil, then it doesnt let us go thorough by raising this error.
            raise Ecko::Plugins::Stripe::InvalidNameError if line_item[:name].nil?

            {
              name: line_item[:name],
              description: line_item[:description],
              images: line_item[:images],
              amount: amount * 100, # Stripe takes values for cents
              currency: line_item[:currency] || default_currency,
              quantity: quantity,
            }
          end
        end

        # When the checkout is a success, this url is triggered.
        def success_url
          "#{callback}/stripe_success?state=#{state}&session_id={CHECKOUT_SESSION_ID}"
        end

        # When the checkout is cancelled, this url is triggered.
        def cancel_url
          "#{callback}/stripe/callbacks/cancel?state=#{state}"
        end

        # The state provided as the code of the payment intent
        def state
          payment_intent.code
        end

        # Gets the currency from the configurations
        def default_currency
          Ecko::Plugins::Stripe::Configurations.instance.currency
        end

        # Callback url for the checkout process to come back to when the payment is complete or
        # cancelled.
        def callback
          @callback ||= Ecko::Plugins::Stripe::Configurations.instance.callback
        end

        # Validates and returns boolean if the line item is present or not.
        def valid_line_items?
          params[:line_items].present? && params[:line_items].is_a?(Array)
        end

        # This is the payment intent provided from the checkout process only.
        # It can be configured when intent is already building outside of the checkout
        # process.
        def intent
          params[:intent]
        end

        # Creates an intent or pull the intent from the given checkout request
        # Here we save the params to make sure to get data correctly.
        def payment_intent
          @payment_intent ||= intent || ::StripePaymentIntent.create(
            reference: 'payment_only',
            metadata: params.as_json,
            payable_type: params[:payable_type],
            payable_id: params[:payable_id]
          )
        end
      end
    end
  end
end
