require "net/http"
require "json"

require "fyber_gateway/offers_request"
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
    body["offers"]
  end

  private

  def read_response(response)
    fail(ResponseInvalidError, "Response body is empty") unless response.body

    response.body.freeze

    signature = response["X-Sponsorpay-Response-Signature"]
    body = JSON.parse(response.body)

    fail(ResponseInvalidError, body["message"]) if response.code != "200"

    unless SignatureValidator.new(signature, response.body, api_key).valid?
      fail SignatureInvalidError, "Invalid response signature"
    end

    body
  end

  attr_reader :api_key, :params
end
