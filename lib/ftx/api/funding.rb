# frozen_string_literal: true

require_relative 'private'

class FTX::API::Funding < FTX::API::Private

  def payments(query = {})
    send_request(:get, '/funding_payments', query)
  end

  def rates(query = {})
    send_request(:get, '/funding_rates', query)
  end
  
end
