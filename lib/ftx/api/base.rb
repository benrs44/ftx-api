# frozen_string_literal: true

require 'httparty'

class FTX::API::Base
  
  attr_reader :config, :key, :secret

  include HTTParty
  base_uri 'https://ftx.com/api'

  def initialize(args = {})
    @config = FTX::API::Config.new(args.dig(:config))
    @key = args.dig(:key)
    @secret = args.dig(:secret)
  end

  protected

  def send_request(method, path, headers, query)
    uuid = SecureRandom.uuid
    print_log(:info, "[API] #{uuid} #{method.upcase} '#{path}' query = #{query}")

    if method == :get
      body_or_query = :query
    else
      body_or_query = :body
      query = query.to_json
    end

    begin
      response = self.class.send(
        method, 
        path, 
        headers: headers,
        timeout: @config.timeout,
        body_or_query.to_sym => query
      )

      print_log(:info, "[API] #{uuid} response #{response}")
      return parse_response(response)
    rescue => error
      print_log(:error, "[API] #{uuid} raise exception #{error.message}")
      raise error
    end
  end

  private

  def parse_response(response)
    response = response.parsed_response
    if response.dig("success")
      response.dig("result").symbolize_keys
    else
      response.symbolize_keys
    end
  end

  def print_log(method, message)
    logger = @config.logger
    if logger
      puts "#{method}: #{message}"
    end
  end
  
end