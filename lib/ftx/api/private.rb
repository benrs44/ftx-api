# frozen_string_literal: true

require_relative 'base'

class FTX::API::Private < FTX::API::Base

  protected

  def send_request(method, path, query)
    super(method, path, headers(method, path, query), query)
  end

  def headers(*args)
    {
      'FTX-KEY' => key,
      'FTX-SIGN' => signature(*args),
      'FTX-TS' => ts.to_s,
    }
  end

  def signature(*args)
    OpenSSL::HMAC.hexdigest(digest, secret, signature_payload(*args))
  end

  def signature_payload(method, path, query)
    payload = [ts, method.to_s.upcase, "/api", path].compact_blank
    
    if method==:post
      payload.push(query.to_json)
    elsif method==:get
      payload.push("?" + URI.encode_www_form(query))
    end unless query.empty?

    "#{payload.join}".encode("UTF-8")
  end

  def ts
    @ts ||= (Time.now.to_f * 1000).to_i
  end

  def digest
    @digest ||= OpenSSL::Digest.new('sha256')
  end
  
end