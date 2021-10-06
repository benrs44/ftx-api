require 'test_helper'

class FillsTest < Minitest::Test
  def setup
    @fills = FTX::API::Fills.new(key: ENV['FTX_KEY'], secret: ENV['FTX_SECRET'])
  end

  def test_list
    response = @fills.stub(:print_log, nil) do
      @fills.list
    end

    assert_instance_of Array, response
    assert_hash_has_keys response.first, [:id, :market, :future, :baseCurrency, :quoteCurrency, :type, :side, :price, :size, :orderId, :time, :tradeId, :feeRate, :fee, :feeCurrency, :liquidity] if response.first
  end

end
