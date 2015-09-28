require "digest/sha1"

class FyberGateway
  # Calculates the hash to sign the request to Fyber
  # (see http://developer.fyber.com/content/current/ios/offer-wall/offer-api/#hashkey-calculation)
  class HashCalculator
    # Creates a new hash calculator based on request and api key
    #
    # @param params [Hash] request parameters (see http://developer.fyber.com/content/current/ios/offer-wall/offer-api/)
    # @param api_key [String] application API KEY provided by Fyber
    def initialize(params, api_key)
      @params = params
      @api_key = api_key
    end

    # Calculates secure hash based on the algorithm provided by Fyber
    # (see http://developer.fyber.com/content/current/ios/offer-wall/offer-api/#hashkey-calculation)
    #
    # @returns [String] calculated secure hash
    def calculate
      sorted_params = params.flat_map { |k, v| "#{k}=#{v}" }.sort
      buffer = sorted_params.join("&")
      buffer << "&#{api_key}"

      Digest::SHA1.hexdigest(buffer)
    end

    private

    attr_reader :params, :api_key
  end
end
