require "digest/sha1"

class FyberGateway
  class SignatureValidator
    def initialize(signature, body, api_key)
      @signature = signature
      @body = body
      @api_key = api_key
    end

    def valid?
      buffer = body.dup
      buffer << api_key
      expected = Digest::SHA1.hexdigest(buffer)
      expected == signature
    end

    private

    attr_reader :signature, :body, :api_key
  end
end
