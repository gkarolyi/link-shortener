##
# ActiveRecord model for storing and accessing information
# about user-submitted links.
# New records must have a valid URL attached.
class Link < ApplicationRecord
  validates :url, presence: true
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp }
  before_validation :autocomplete_url

  # Class method for finding a specific record based on
  # its shortcode. Takes a shortcode (String) as a
  # parameter, and returns the associated record (Link).
  def self.find_by_shortcode(shortcode)
    id = ShortConverter::Decoder.call(shortcode)
    find(id)
  end

  # Instance method for accessing a particular record's
  # shortcode. Returns the shortcode (String).
  def shortcode
    ShortConverter::Encoder.call(id)
  end

  # Instance method for recording one visit on a specific
  # Link. Returns True or False.
  def log_visit!
    self.visits += 1
    save
  end

  private

  def autocomplete_url
  end
end
