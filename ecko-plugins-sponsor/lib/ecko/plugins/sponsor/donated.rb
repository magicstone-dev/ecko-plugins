# frozen_string_literal: true

# This class is used to perform post donation and add a donation to the account.
# This actually should be a service that app should run.
module Ecko
  module Plugins
    module Sponsor
      class Donated
        attr_accessor :intent, :account, :package

        # Sets the intent of the donation and finds account and package with whom the
        # intent is related to.
        def initialize(intent)
          @intent = intent
          @account = ::Account.find(intent.payable_id)
          @package = ::DonationPackage.find(intent.metadata['package_id'])
        end

        # Just the processor.
        def process
          create_donation && update_account_sponsorship && close_intent
        end

        private

        # This is to help donations
        def update_account_sponsorship
          account.refresh_sponsorship
        end

        # Close the intent that was used for the donation
        def close_intent
          intent.update(status: 'closed')
        end

        # When the donation has been made, Create a donation for the account.
        def create_donation
          ::Donation.create(account: account, amount: package.amount)
        end

        class << self
          def process(intent)
            new(intent).process
          end
        end
      end
    end
  end
end
