require 'test_helper'

class MarketsTest < Minitest::Test
  def setup
    @markets = FTX::API::Markets.new
  end

  def test_list
    response = @markets.stub(:print_log, nil) do
      @markets.list
    end

    assert_instance_of Array, response

    yfi_market = response.find{|s| s[:name] == 'YFI/USDT' }
    expected_data = {
      :name                  => 'YFI/USDT',
      :enabled               => true,
      :postOnly              => false,
      :type                  => 'spot',
      :baseCurrency          => 'YFI',
      :quoteCurrency         => 'USDT',
      :underlying            => nil,
      :restricted            => false,
      :highLeverageFeeExempt => true,
    }
    assert_hash_to_include expected_data, yfi_market
  end

  def test_single
    response = @markets.stub(:print_log, nil) do
      @markets.get('YFI/USDT')
    end

    assert_instance_of Hash, response

    expected_data = {
      :name                  => 'YFI/USDT',
      :enabled               => true,
      :postOnly              => false,
      :type                  => 'spot',
      :baseCurrency          => 'YFI',
      :quoteCurrency         => 'USDT',
      :underlying            => nil,
      :restricted            => false,
      :highLeverageFeeExempt => true,
    }
    assert_hash_to_include expected_data, response
  end

  def test_orderbook
    response = @markets.stub(:print_log, nil) do
      @markets.orderbook('YFI/USDT', depth: 3)
    end

    assert_instance_of Hash, response

    assert_equal %w[bids asks], response.keys.map(&:to_s)
    assert_instance_of Array, response[:bids]
    assert_instance_of Array, response[:asks]
    assert_equal 3, response[:bids].size
    assert_equal 3, response[:asks].size
  end

  def test_historic
    response = @markets.stub(:print_log, nil) do
      @markets.historic('YFI/USDT', resolution: 30*86400)
    end

    assert_instance_of Array, response
    assert_equal 16, response.size

    assert_equal %w[startTime time open high low close volume], response.first.keys.map(&:to_s)
  end
end
