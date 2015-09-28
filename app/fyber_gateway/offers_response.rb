require "json"

class FyberGateway
  # Encapsulates logic for presenting response from Fyber Offers API
  # (see http://developer.fyber.com/content/current/ios/offer-wall/offer-api)
  class OffersResponse
    # Creates new response object based on response body retrieved from Fyber
    #
    # @param body [String] raw response body as a string
    def initialize(body)
      fail(ResponseInvalidError, "Response body is empty") unless body
      @response = JSON.parse(body)
    rescue JSON::ParserError
      raise(ResponseInvalidError, "Response body is invalid")
      # in real system we need to at least log it here
    end

    # @returns [Array] of offers (as hashes)
    def offers
      @response["offers"]
    end

    # @returns [Number] Count of offers returned
    def count
      @response["count"].to_i
    end

    # @returns [Number] Total number of pages
    def pages
      @response["pages"].to_i
    end

    # @returns [String] Text message returned from Fyber
    def message
      @response["message"]
    end

    # @returns [Hash] Hash representation of the original response
    def raw
      @response
    end
  end
end
