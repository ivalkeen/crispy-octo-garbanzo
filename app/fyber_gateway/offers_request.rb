require "fyber_gateway/hash_calculator"

class FyberGateway
  class OffersRequest
    def initialize(params, api_key)
      @params = params
      @api_key = api_key
    end

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
