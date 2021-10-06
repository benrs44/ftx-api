# frozen_string_literal: true

require_relative 'private'

class FTX::API::Fills < FTX::API::Private

  def list(query = {})
    send_request(:get, "/fills", query)
  end
  
end
