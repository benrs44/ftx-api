require 'test_helper'

class FuturesTest < Minitest::Test
  def setup
    @futures = FTX::API::Futures.new
  end

  def test_list
    response = @futures.stub(:print_log, nil) do
      @futures.list
    end

    assert_instance_of Array, response

    yfi_market = response.find{|s| s[:name] == 'YFI-PERP' }
    expected_data = {
      :name                  => 'YFI-PERP',
      :enabled               => true,
      :postOnly              => false,
      :type                  => 'perpetual',
      :underlying            => 'YFI',
      :description           => "Yearn.Finance Perpetual Futures",
      :expired               => false,
    }
    assert_hash_to_include expected_data, yfi_market
  end

  def test_single
    response = @futures.stub(:print_log, nil) do
      @futures.get('YFI-PERP')
    end

    assert_instance_of Hash, response

    expected_data = {
      :name                  => 'YFI-PERP',
      :enabled               => true,
      :postOnly              => false,
      :type                  => 'perpetual',
      :underlying            => 'YFI',
      :description           => "Yearn.Finance Perpetual Futures",
      :expired               => false,
    }
    assert_hash_to_include expected_data, response
  end

  def test_stats
    response = @futures.stub(:print_log, nil) do
      @futures.stats('YFI-PERP')
    end

    assert_instance_of Hash, response
    assert_hash_has_keys response, [:volume, :nextFundingRate, :nextFundingTime, :openInterest]
  end

  def test_funding_rates
    response = @futures.stub(:print_log, nil) do
      @futures.funding_rates(future: 'YFI-PERP')
    end

    assert_instance_of Array, response

    expected_data = {
      :future                => 'YFI-PERP',
    }
    assert_hash_to_include expected_data, response.first
  end
end
