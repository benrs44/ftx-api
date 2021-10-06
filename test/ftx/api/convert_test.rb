require 'test_helper'

class ConvertTest < Minitest::Test
  def setup
    @convert = FTX::API::Convert.new(key: ENV['FTX_KEY'], secret: ENV['FTX_SECRET'])
  end

  def test_new_quote
    response = @convert.stub(:print_log, nil) do
      @convert.new_quote(size: 0.01, fromCoin: 'USD', toCoin: 'BTC')
    end

    assert_instance_of Hash, response
    assert_hash_has_keys response, [:quoteId]
  end

  def test_get_quote
    quote = @convert.new_quote(size: 0.01, fromCoin: 'USD', toCoin: 'BTC')
    response = @convert.stub(:print_log, nil) do
      @convert.get_quote(quote[:quoteId])
    end

    assert_instance_of Hash, response
    
    expected_data = {
      :id           => quote[:quoteId],
      :baseCoin     => "BTC",
      :quoteCoin    => "USD",
      :side         => "buy",
      :fromCoin     => "USD",
      :toCoin       => "BTC",
      :cost         => 0.01,
      :filled       => false,
    }
    assert_hash_to_include expected_data, response
  end
end
