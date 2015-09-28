require "net/http"

require "fyber_gateway/offers_request"
require "fyber_gateway/offers_response"
require "fyber_gateway/signature_validator"

# Main interface to communicate with Fyber API from the application
#
class FyberGateway
  class ResponseInvalidError < StandardError; end
  class SignatureInvalidError < StandardError; end

  # Create a new gateway using specific request parameters and api_key
  #
  # @param params [Hash] request parameters (see http://developer.fyber.com/content/current/ios/offer-wall/offer-api/)
  # @param api_key [String] application API KEY provided by Fyber
  def initialize(params, api_key)
    @params = params
    @api_key = api_key
  end

  # Create a new gateway using specific request parameters and api_key
  #
  # @return [Array] of offers, each offer is Hash (see http://developer.fyber.com/content/current/ios/offer-wall/offer-api/)
  def load_offers
    request = OffersRequest.new(params, api_key)
    response = Net::HTTP.get_response(URI(request.url))
    body = read_response(response)
    body
  end

  private

  def read_response(response)
    offers_response = OffersResponse.new(response.body)
    # In the real system we would add logging here and use notifications service to notify about the issue
    # but we don't want to show the message returned from the server to the end user
    fail(ResponseInvalidError, "HTTP status: #{response.code}") if response.code != "200"

    signature = response["X-Sponsorpay-Response-Signature"]
    unless SignatureValidator.new(signature, response.body, api_key).valid?
      fail SignatureInvalidError, "Invalid response signature"
    end

    offers_response
  end

  attr_reader :api_key, :params
end
