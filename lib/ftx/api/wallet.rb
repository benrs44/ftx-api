# frozen_string_literal: true

require_relative 'private'

class FTX::API::Wallet < FTX::API::Private

  def coins
    send_request(:get, "/wallet/coins", {})
  end

  def balances
    send_request(:get, "/wallet/balances", {})
  end

  def all_balances
    send_request(:get, "/wallet/all_balances", {})
  end
  
end
