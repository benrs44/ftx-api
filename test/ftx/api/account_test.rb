require 'test_helper'

class AccountTest < Minitest::Test
  def setup
    @account = FTX::API::Account.new(key: ENV['FTX_KEY'], secret: ENV['FTX_SECRET'])
  end

  def test_get
    response = @account.stub(:print_log, nil) do
      @account.get
    end

    assert_instance_of Hash, response
    assert_hash_has_keys response, [ :username,
                                     :collateral,
                                     :freeCollateral,
                                     :totalAccountValue,
                                     :totalPositionSize,
                                     :initialMarginRequirement,
                                     :maintenanceMarginRequirement,
                                     :marginFraction,
                                     :openMarginFraction,
                                     :liquidating,
                                     :backstopProvider,
                                     :positions,
                                     :takerFee,
                                     :makerFee,
                                     :leverage,
                                     :positionLimit,
                                     :positionLimitUsed,
                                     :useFttCollateral,
                                     :chargeInterestOnNegativeUsd,
                                     :spotMarginEnabled,
                                     :spotLendingEnabled
                                   ]
  end

  def test_positions
    response = @account.stub(:print_log, nil) do
      @account.positions
    end

    assert_instance_of Array, response
    
    if response.size > 0
      assert_hash_has_keys response.first, [:future,
                                             :size,
                                             :side,
                                             :netSize,
                                             :longOrderSize,
                                             :shortOrderSize,
                                             :cost,
                                             :entryPrice,
                                             :unrealizedPnl,
                                             :realizedPnl,
                                             :initialMarginRequirement,
                                             :maintenanceMarginRequirement,
                                             :openSize,
                                             :collateralUsed,
                                             :estimatedLiquidationPrice]
    end
  end

end
