class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true
  validates :url,
            format: { with: URI::DEFAULT_PARSER.make_regexp },
            if: ->(link) { link.url.present? }

  def gist?
    url.include?("gist.github.com")
  end

  def git_hash
    url.split('/').last
  end
end
