# Ecko::Plugins::Stripe

This gem helps in interacting and setting stripe to help in running stripe based functionalities in
mastodon. The gem is developed under the ecko plugins flagship where all these plugins development
started.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ecko-plugins-stripe'
```

And then execute:

 $ bundle install

Or install it yourself as:

    $ gem install ecko-plugins-stripe

## Usage
We can generate payment intent model and migration for intent by
rails generate ecko:plugins:stripe:payment_intention


We can do a checkout by
```ruby
 Ecko::Plugins.stripe.checkout(
		{
				submit_type: 'donate',
				success_message: 'Thanks for being part of our community, Your donation was well received', # Need to add translation options,
				callback: 'Ecko::Plugins::Sponsor::Donated',
				metadata: metadata,
				payable_type: account.class.name,
				payable_id: account.id,
				line_items: [
						{
								quantity: 1,
								amount: 100,
								name: "Demo Payment",
								description: 'Demo for the instance',
						}
				]
		}
)
```

## Development

We can extend this gem by adding multiple functionalities of stripe. We currently have the checkout feature which helps
in payment process. The gem also helps in setting up a payment intent structure which works as the model for the intent
of payment.

## Contributing

We're following a protocol called the Collective Code Construction Contract (C4) that says if you are addressing a valid problem, your code gets merged. Everything else follows from that.
Bug reports and pull requests are welcome on GitHub at https://github.com/magicstone-dev/ecko-plugins. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [GPL/AGPL License](https://opensource.org/licenses/GPL/AGPL).

## Code of Conduct

Everyone interacting in the Ecko::Plugins::Stripe project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ecko-plugins-stripe/blob/master/CODE_OF_CONDUCT.md).
