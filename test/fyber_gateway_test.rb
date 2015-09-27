require "test_helper"
require "fyber_gateway"

class TestFyberGateway < Minitest::Test
  def setup
    @fixture = fixture(:example)
    @gateway = FyberGateway.new(@fixture["params"], @fixture["api_key"])
  end

  def test_get_response_no_offers
    WebMock.stub_request(:get, @fixture["url"])
      .to_return(fixed_response(:raw_no_offers))

    offers = @gateway.load_offers
    assert_equal [], offers
  end

  def test_get_response_with_offers
    WebMock.stub_request(:get, @fixture["url"])
      .to_return(fixed_response(:raw_with_offers))

    offers = @gateway.load_offers
    assert_equal 1, offers.size
    assert_equal 13_554, offers[0]["offer_id"]
  end

  def test_raises_error_when_wrong_signature
    WebMock.stub_request(:get, @fixture["url"])
      .to_return(fixed_response(:raw_no_offers_bad_signature))

    assert_raises FyberGateway::SignatureInvalidError do
      @gateway.load_offers
    end
  end

  def test_raises_error_when_fyber_error
    WebMock.stub_request(:get, @fixture["url"])
      .to_return(fixed_response(:raw_bad_request))

    assert_raises FyberGateway::ResponseInvalidError do
      @gateway.load_offers
    end
  end

  def test_raises_error_when_empty_body
    WebMock.stub_request(:get, @fixture["url"])
      .to_return(body: nil)

    assert_raises FyberGateway::ResponseInvalidError do
      @gateway.load_offers
    end
  end
end
