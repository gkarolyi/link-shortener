require "application_system_test_case"

class LinksTest < ApplicationSystemTestCase
  test "visiting the home page" do
    visit root_url

    assert_selector "h1", text: "Welcome!"
  end

  test "adding a new valid link" do
    visit root_url

    fill_in "link_url", with: 'bbc.co.uk'
    click_on 'Shorten it!'

    assert_selector "p", text: "Short URL has been copied to the clipboard!"
  end

  test "adding a new invalid link" do
    visit root_url

    fill_in "link_url", with: 'notavalidurl'
    click_on 'Shorten it!'

    assert_selector "p", text: "The URL you entered doesn't seem to be valid!"
  end
end
