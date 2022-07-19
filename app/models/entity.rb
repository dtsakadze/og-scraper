class Entity < ApplicationRecord
  validate :check_url

  before_create :extract_tags

  def check_url
    uri = URI.parse(url)
    return if uri.is_a?(URI::HTTP) && !uri.host.nil?

    errors.add(:base, "Invalid URL")
  end

  def extract_tags
    ogp = Ogpr.fetch(url)
    og = ogp.open_graph

    unless og
      errors.add(:base, "Something went wrong. Please try again later.")
      throw(:abort)
    end

    og_tags = []
    og.each_pair { |k, v| og_tags.push({ "#{k}": v }) }
    self.tags = og_tags

    check_minimal_tags
  end

  def check_minimal_tags
    keys = tags.map { |el| el.keys }.flatten
    return if (['og:title', 'og:description'] - keys).empty?

    errors.add(:base, "OG data is incomplete/missing")
    throw(:abort)
  end
end
