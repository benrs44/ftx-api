# frozen_string_literal: true

require_relative 'private'

class FTX::API::Convert < FTX::API::Private

  def new_quote(query = {})
    raise ArgumentError.new(
      "Size, fromCoin, toCoin params required"
      ) unless [:fromCoin, :toCoin, :size].all? { |i| query.include? i }
    
    send_request(:post, "/otc/quotes", query)
  end

  def get_quote(quote_id)
    send_request(:get, "/otc/quotes/#{quote_id}", {})
  end

  def accept_quote(quote_id)   
    send_request(:post, "/otc/quotes/#{quote_id}/accept", {})
  end
  
end