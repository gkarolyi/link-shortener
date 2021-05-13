class Link < ApplicationRecord
  validates :url, presence: true
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp }

  def log_visit!
    self.visits += 1
  end
end
