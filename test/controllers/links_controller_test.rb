require "test_helper"

class LinksControllerTest < ActionDispatch::IntegrationTest
  test "shortened link should redirect" do
    link = Link.create(url: "google.com")
    get link_url(link.shortcode)

    assert_response :redirect
  end
end
