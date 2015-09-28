require "test_helper"
require "fyber_gateway/offers_response"

class FyberGateway
  class TestOffersResponse < Minitest::Test
    def setup
      @fixture = fixture(:example)
      @response = OffersResponse.new(@fixture["response"])
    end

    def test_offers
      assert_instance_of(Array, @response.offers)
      assert_equal(1, @response.offers.size)
    end

    def test_count
      assert_equal(30, @response.count)
    end

    def test_pages
      assert_equal(3, @response.pages)
    end

    def test_message
      assert_equal("OK", @response.message)
    end

    def test_currency
      assert_equal("Coins", @response.currency)
    end

    def test_raw
      assert_instance_of(Hash, @response.raw)
      assert_instance_of(Array, @response.raw["offers"])
    end
  end
end
