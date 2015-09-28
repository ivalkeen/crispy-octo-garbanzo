require "test_helper"

require "capybara"
require "timecop"

require "config"
require "server"
require "fyber_gateway/offers_request"

Capybara.app = Cuba

class TestApplication < Minitest::Test
  include Capybara::DSL

  def setup
    Timecop.freeze
  end

  def teardown
    Timecop.return
    WebMock.reset!
  end

  def test_empty_message
    WebMock.stub_request(:get, build_url)
      .to_return(fixed_response(:raw_no_offers))

    fill_form

    assert page.has_content?("No offers available")
  end

  def test_offers_rendered
    WebMock.stub_request(:get, build_url)
      .to_return(fixed_response(:raw_with_offers))

    fill_form

    assert page.has_content?("TapFish")
    assert page.has_content?("Payout: 90 Coins")
  end

  def test_signature_error_rendered
    WebMock.stub_request(:get, build_url)
      .to_return(fixed_response(:raw_no_offers_bad_signature))

    fill_form

    assert page.has_content?("Invalid response signature")
  end

  def test_response_error_rendered
    WebMock.stub_request(:get, build_url)
      .to_return(fixed_response(:raw_bad_request))

    fill_form

    msg = "HTTP status: 400"
    assert page.has_content?(msg)
  end

  def test_validate_params
    visit "/"

    click_button("Get offers")

    assert page.has_content?("Please, provide UID")
  end

  private

  def build_url
    params = Config::DEFAULT_PARAMS.merge(uid: "player1", page: "2", pub0: "campaign2", timestamp: Time.now.utc.to_i.to_s)
    FyberGateway::OffersRequest.new(params, Config::API_KEY).url
  end

  def fill_form
    visit "/"

    fill_in("uid", with: "player1")
    fill_in("page", with: "2")
    fill_in("pub0", with: "campaign2")

    click_button("Get offers")
  end
end
