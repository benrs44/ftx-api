# frozen_string_literal: true

require_relative 'private'

class FTX::API::Orders < FTX::API::Private

  def open(query = {})
    send_request(:get, "/orders", query)
  end

  def history(query = {})
    send_request(:get, "/orders/history", query)
  end

  def get(order_id)
    send_request(:get, "/orders/#{order_id}", {})
  end

  def get_by_client_id(client_id)
    send_request(:get, "/orders/by_client_id/#{client_id}", {})
  end

  def create(query = {})
    raise ArgumentError.new(
      "Market, side, price (can be nil), tupe and size params required"
      ) unless [:market, :side, :price, :type, :size].all? { |i| query.include? i }
    
    send_request(:post, "/orders", query)
  end
  
end
