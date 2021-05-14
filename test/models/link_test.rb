require "test_helper"

class LinkTest < ActiveSupport::TestCase
  test "should not save link without a URL" do
    link = Link.new
    assert_not link.save
  end

  test "should not save link with an invalid URL" do
    link = Link.new(url: 'kbariblaknblsaduf')
    assert_not link.save
  end

  test "should save a link with a correctly formatted URL" do
    link = Link.new(url: 'http://www.google.com')
    assert link.save
  end

  test "a new test should have zero visits" do
    link = Link.create(url: 'http://www.google.com')
    assert link.visits.zero?
  end

  test "should be able to log visits to a link" do
    link = Link.create(url: 'http://www.google.com')
    15.times { link.log_visit! }
    assert link.visits == 15
  end

  test "should autocorrect a short URL" do
    link = Link.create(url: 'bbc.co.uk')
    assert link.url == 'http://bbc.co.uk'
  end

  test "should autocorrect a longer URL" do
    link = Link.create(url: 'bbc.com/news/world-us-canada-57114728')
    assert link.url.starts_with? 'http://'
  end

  test "should be able to retrieve a link's shortcode" do
    link = Link.create(url: 'google.com')
    assert link.shortcode
  end

  test "should be able to retrieve a link by its shortcode" do
    link = Link.create(url: 'news.ycombinator.com/')
    assert Link.find_by_shortcode(link.shortcode)
  end
end
