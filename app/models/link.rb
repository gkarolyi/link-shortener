##
# ActiveRecord model for storing and accessing information
# about user-submitted links.
# New records must have a valid URL attached.
class Link < ApplicationRecord
  validates :url, presence: true
  validate :url_must_be_valid

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

  # Custom validator to ensure added URLs either look right
  # (match the URI generic regexp) or can be reached after
  # simple autocorrection.
  def url_must_be_valid
    # Return if no URL is given - the presence validator handles
    # these cases.
    return if url.nil? || correctly_formatted? || url_reachable?

    errors.add(:url, "must be reachable or of the right format")
  end

  def correctly_formatted?
    url.match? URI::DEFAULT_PARSER.make_regexp
  end

  # Sends a request to the autocorrected URL to see if it
  # responds. Returns true if successful, otherwise false.
  def url_reachable?
    build_correct_url.read
                     .status[0] == "200"
  # Return false if the URL build step failed, or if the built
  # URL is not reachable.
  rescue NoMethodError, SocketError
    false
  end

  # Attempts to autocorrect incomplete URLs by creating
  # URI::HTTP objects from the inferred host and path.
  # Returns URI::HTTP if successful, otherwise false.
  def build_correct_url
    url_components = url.split('/')
    parameters = { host: url_components[0] }
    parameters[:path] = build_path unless url_components.one?
    self.url = URI::HTTP.build(parameters)
  rescue URI::InvalidComponentError
    false
  end

  def build_path
    url.split('/')[1..]
       .map { |element| element.prepend '/' }
       .join
  end
end
