# frozen_string_literal: true

require_relative 'private'

class FTX::API::Account < FTX::API::Private

  def get
    send_request(:get, "/account", {})
  end

  def positions
    send_request(:get, "/positions", {})
  end
  
end
