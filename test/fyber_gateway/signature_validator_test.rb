require "test_helper"
require "fyber_gateway/signature_validator"

class FyberGateway
  class TestSignatureValidator < Minitest::Test
    def setup
      @fixture = fixture(:example)
    end

    def test_valid
      validator = SignatureValidator.new("a9fe05f12bd35b73cc5608825d556d373f345197", "body", "api_key")
      assert validator.valid?
    end

    def test_invalid
      validator = SignatureValidator.new("invalid", "body", "api_key")
      assert !validator.valid?
    end
  end
end
