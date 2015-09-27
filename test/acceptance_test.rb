require "test_helper"

require "server"
require "capybara"

Capybara.app = Cuba

class TestApplication < Minitest::Test
  include Capybara::DSL

  def test_ui
    visit "/"

    fill_in("uid", with: "player1")
    fill_in("page", with: "2")
    fill_in("pub0", with: "campaign2")

    click_button("Get offers")

    assert page.has_content?("Results")
  end
end
