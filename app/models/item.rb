class Item < ActiveRecord::Base
  belongs_to :list

  validates :name, presence: true
  validates :list_id, numericality: true

  def full_url
    clean_url = url.gsub(/^http:\/\//, "")
    return "http://#{clean_url}"
  end
end