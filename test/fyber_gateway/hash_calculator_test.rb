require "test_helper"
require "fyber_gateway/hash_calculator"

class FyberGateway
  class TestHashCalculator < Minitest::Test
    def setup
      @fixture = fixture(:example)
      @calculator = FyberGateway::HashCalculator.new(@fixture["params"], @fixture["api_key"])
    end

    def test_calculates_correct_hash
      hash = @calculator.calculate
      expected = @fixture["hashkey"]
      assert_equal expected, hash
    end
  end
end
