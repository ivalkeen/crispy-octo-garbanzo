require "test_helper"
require "fyber_gateway/offers_request"

class FyberGateway
  class TestOffersRequest < Minitest::Test
    def setup
      @fixture = fixture(:example)

      @request_builder = FyberGateway::OffersRequest.new(
        @fixture["params"],
        @fixture["api_key"],
      )
    end

    def test_url
      url = @request_builder.url
      assert_equal(@fixture["url"], url)
    end
  end
end
