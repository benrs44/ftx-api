# frozen_string_literal: true

require_relative 'public'

class FTX::API::Markets < FTX::API::Public
  base_uri 'https://ftx.com/api'

  def list
    send_request(:get, '/markets', {})
  end

  def get(market_name)
    send_request(:get, "/markets/#{market_name}", {})
  end

  def orderbook(market_name, depth: nil)
    send_request(:get, "/markets/#{market_name}/orderbook", depth: depth)
  end

  def historic(market_name, query = {})
    raise ArgumentError.new(
      "Resolution required as a window length in seconds. 
      options: 15, 60, 300, 900, 3600, 14400, 86400, or 
      any multiple of 86400 up to 30*86400") unless query.dig(:resolution)
    
    send_request(:get, "/markets/#{market_name}/candles", query)
  end
end
