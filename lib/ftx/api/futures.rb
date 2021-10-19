# frozen_string_literal: true

require_relative 'public'

class FTX::API::Futures < FTX::API::Public

  def list
    send_request(:get, '/futures', {})
  end

  def get(futures_name)
    send_request(:get, "/futures/#{futures_name}", {})
  end

  def stats(futures_name)
    send_request(:get, "/futures/#{futures_name}/stats", {})
  end

  def funding_rates(query = {})
    send_request(:get, '/funding_rates', query)
  end
  
end
