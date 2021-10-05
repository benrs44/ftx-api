require 'test_helper'

class OrdersTest < Minitest::Test
  def setup
    @orders = FTX::API::Orders.new(key: ENV['FTX_KEY'], secret: ENV['FTX_SECRET'])
  end

  def test_open
    response = @orders.stub(:print_log, nil) do
      @orders.open
    end

    assert_instance_of Array, response
    
    expected_data = {
      :status         => 'open',
    }
    assert_hash_to_include expected_data, response.first if response.first
  end

  def test_history
    response = @orders.stub(:print_log, nil) do
      @orders.history
    end

    assert_instance_of Array, response
    
    expected_data = {
      :status         => 'closed',
    }
    assert_hash_to_include expected_data, response.first if response.first
  end

  def test_get
    history = @orders.history
    id = history.empty? ? nil : history.first.dig(:id)

    if id
      response = @orders.stub(:print_log, nil) do
        @orders.get(id)
      end

    
      assert_instance_of Hash, response  
      assert_hash_has_keys response, [:id, :clientId, :market, :type, :side, :price, :size, :status, :filledSize, :remainingSize, :reduceOnly, :liquidation, :avgFillPrice, :postOnly, :ioc, :createdAt, :future]
    end
  end

end
