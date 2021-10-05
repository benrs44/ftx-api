# frozen_string_literal: true

require_relative 'base'

class FTX::API::Public < FTX::API::Base

  protected

  def send_request(method, path, query)
    super(method, path, {}, query)
  end
  
end
