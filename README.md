# FTX::API

This gem is a ruby SDK for the FTX crypto exchange REST API.

API docs can be found on the [FTX developer site](https://docs.ftx.com/)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ftx-api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ftx-api

## Usage

### Markets

Initialize a markets session:
```ruby
markets = FXT::API::Markets.new
```

Query for all current prices:
```ruby
markets.list
```

Fetch a single market price:
```ruby
markets.get('BTC/USD')
```

Check for market depth:
```ruby
markets.orderbook('BTC/USD', depth: 3)
```

View historic prices:
```ruby
markets.historic('BTC/USD', resolution: 86400*30)
```
*Check the [FTX API docs](https://docs.ftx.com/?python#get-historical-prices) for additional parameters such as start_time and end_time*

Note: resolution is in seconds so 86,400 would be the number of seconds in a day. As a default, the API responds with 12 months of historical prices.

### Futures

Initialize a futures session:
```ruby
futures = FXT::API::Futures.new
```

Query for all current prices:
```ruby
futures.list
```

Fetch a single market price:
```ruby
futures.get('BTC-PERP')
```

### Account

Initialize an account session:
```ruby
account = FXT::API::Account.new(key: 'YOUR FTX KEY', secret: 'YOUR FTX SECRET')
```

Fetch information about account associated with key/secret:
```ruby
account.get
```

Query for all current account positions:
```ruby
account.positions
```

### Wallet

Initialize a wallet session:
```ruby
wallet = FXT::API::Wallet.new(key: 'YOUR FTX KEY', secret: 'YOUR FTX SECRET')
```

Query for all available coins:
```ruby
wallet.coins
```

Query for all current coin balances in your account:
```ruby
wallet.balances
```

Query for all current coin balances split into a hash by subaccount:
```ruby
wallet.all_balances
```

### Orders

Initialize an orders session:
```ruby
orders = FXT::API::Orders.new(key: 'YOUR FTX KEY', secret: 'YOUR FTX SECRET')
```

Query for all open orders:
```ruby
orders.open
```

Query for all historical orders:
```ruby
orders.history
```

Fetch a specific order by FTX `orderId`:
```ruby
orders.get(order_id)
```

Fetch a specific order by `clientId`:
```ruby
orders.get_by_client_id(clientId)
```

Create a new order:
```ruby
args = {
      market:       "XRP-PERP",     # coin or futures name
      side:         "sell",         # "buy" or "sell"
      price:        0.306525,       # Send nil for market orders.
      type:         "limit",        # "limit" or "market"
      size:         31431.0,
      reduceOnly:   false,          # optional; default is false
      ioc:          false,          # optional; default is false
      postOnly:     false,          # optional; default is false
      clientId:     nil             # optional; client order id
    }

orders.create(args)
```

Note: the create order method is not included as a test, because I have not been able to find FTX test keys and it seems a bit ridiculous to execute a live order for testing.

*Check the [FTX API docs](https://docs.ftx.com/#orders) for all parameters*

### Fills

Initialize an fills session:
```ruby
fills = FXT::API::Orders.new(key: 'YOUR FTX KEY', secret: 'YOUR FTX SECRET')
```

Query for all fills:
```ruby
fills.list
```
or

```ruby
fills.list(market: 'BTC/USD')
```

Note: market is optional

### Convert Coins

Initialize an convert session:
```ruby
convert = FXT::API::Convert.new(key: 'YOUR FTX KEY', secret: 'YOUR FTX SECRET')
```

Create a new quote:
```ruby
args = {
      size:         0.01,   # 0.01 is the smallest increment
      fromCoin:     "USD",
      toCoin:       "BTC",
    }

convert.new_quote(args)
```

Response:
```ruby
{:quoteId=>2*******3}
```

Fetch a quote:
```ruby
convert.get_quote('quoteId')
```

Accept a quote:
```ruby
convert.accept_quote('quoteId')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.

You'll then need to add environment variables `ENV['FTX_KEY']` and `ENV['FTX_SECRET']`. API keys can be created in your [FTX settings page](https://ftx.com/profile).

Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/benrs44/ftx-api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/benrs44/ftx-api/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ftx::Api project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/benrs44/ftx-api/blob/master/CODE_OF_CONDUCT.md).