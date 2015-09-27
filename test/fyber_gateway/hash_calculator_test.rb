require "test_helper"
require "fyber_gateway/hash_calculator"

module FyberGateway
  class TestHashCalculator < Minitest::Test
    def setup
      @calculator = FyberGateway::HashCalculator.new(params, api_key)
    end

    def test_calculates_correct_hash
      hash = @calculator.calculate
      assert_equal "7a2b1604c03d46eec1ecd4a686787b75dd693c4d", hash
    end

    private

    # example params are taken from the documentation example
    # http://developer.fyber.com/content/current/ios/offer-wall/offer-api/
    def params
      {
        "appid": "157",
        "uid": "player1",
        "ip": "212.45.111.17",
        "locale": "de",
        "device_id": "2b6f0cc904d137be2e1730235f5664094b831186",
        "ps_time": "1312211903",
        "pub0": "campaign2",
        "page": "2",
        "timestamp": "1312553361",
      }
    end

    # api key is taken from the documentation example
    # http://developer.fyber.com/content/current/ios/offer-wall/offer-api/
    def api_key
      "e95a21621a1865bcbae3bee89c4d4f84"
    end
  end
end
