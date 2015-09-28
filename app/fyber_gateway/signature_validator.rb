require "digest/sha1"

class FyberGateway
  # Encapsulates logic for response signature validation
  # (see http://developer.fyber.com/content/current/ios/offer-wall/offer-api/#signed-response)
  class SignatureValidator
    # Creates a new configured signature validator
    #
    # @param signature [String] signature provided in the response
    # @param body [String] response body represented as String
    # @param api_key [String] application API KEY provided by Fyber
    def initialize(signature, body, api_key)
      @signature = signature
      @body = body
      @api_key = api_key
    end

    # Check if the signature is valid for the given body and api key
    #
    # @returns [Boolean] if signature is valid or not
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
