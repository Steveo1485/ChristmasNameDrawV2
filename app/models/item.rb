class Item < ActiveRecord::Base
  belongs_to :list, touch: true

  validates :name, presence: true
  validates :list_id, numericality: true

  default_scope { order(created_at: :asc) }

  def full_url
    clean_url = url.gsub(/^http:\/\//, "")
    return "http://#{clean_url}"
  end
end