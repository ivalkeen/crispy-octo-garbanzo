require "fyber_gateway/hash_calculator"

class FyberGateway
  # Encapsulates logic for preparing request to Fyber Offers API
  # (see http://developer.fyber.com/content/current/ios/offer-wall/offer-api)
  class OffersRequest
    # Creates a new request object based on request parameters and api_key
    #
    # @param params [Hash] request parameters (see http://developer.fyber.com/content/current/ios/offer-wall/offer-api/)
    # @param api_key [String] application API KEY provided by Fyber
    def initialize(params, api_key)
      @params = params
      @api_key = api_key
    end

    # Generates URL to Fyber Offers API based on provided parameters
    #
    # @return [String] complete request URI represented as string (signed with secure hash)
    def url
      url = "http://api.fyber.com/feed/v1/offers.json?"
      url << params.flat_map { |k, v| "#{k}=#{CGI.escape(v.to_s)}" }.sort.join("&")
      url << "&hashkey=#{HashCalculator.new(params, api_key).calculate}"
      url
    end

    private

    attr_reader :api_key, :params
  end
end
