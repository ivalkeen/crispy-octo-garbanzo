require "fyber_gateway/hash_calculator"

class FyberGateway
  class OffersRequest
    def initialize(params, api_key)
      @params = params
      @api_key = api_key
    end

    def url
      url = "http://api.fyber.com/feed/v1/offers.json?"
      url << params.flat_map { |k, v| "#{k}=#{v}" }.sort.join("&")
      url << "&hashkey=#{HashCalculator.new(params, api_key).calculate}"
      url
    end

    attr_reader :api_key, :params, :hash_calculator
  end
end
