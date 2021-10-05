require 'test_helper'

class WalletTest < Minitest::Test
  def setup
    @wallet = FTX::API::Wallet.new(key: ENV['FTX_KEY'], secret: ENV['FTX_SECRET'])
  end

  def test_coins
    response = @wallet.stub(:print_log, nil) do
      @wallet.coins
    end

    assert_instance_of Array, response
    
    btc_coin = response.find{|s| s[:id] == 'BTC' }
    expected_data = {
      :id                    => 'BTC',
      :name                  => 'Bitcoin',
      :isEtf                 => false,
      :isToken               => false,
      :usdFungible           => false,
    }
    assert_hash_to_include expected_data, btc_coin
  end

  def test_balances
    response = @wallet.stub(:print_log, nil) do
      @wallet.balances
    end

    assert_instance_of Array, response
    
    if response.size > 0
      assert_hash_has_keys response.first, [:coin, :total, :free, :availableWithoutBorrow, :usdValue, :spotBorrow]
    end
  end

  def test_all_balances
    response = @wallet.stub(:print_log, nil) do
      @wallet.all_balances
    end

    assert_instance_of Hash, response
    
    assert_hash_has_keys response, [:main]
  end

end
