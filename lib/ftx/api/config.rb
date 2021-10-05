# frozen_string_literal: true

class FTX::API::Config
  
  attr_accessor :timeout, :logger

  def initialize(data = nil)
    data ||= {}
    @timeout = data.fetch(:timeout, 30)
    @logger = data.dig(:logger)
  end

end