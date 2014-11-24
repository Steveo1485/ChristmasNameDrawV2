class List < ActiveRecord::Base
  belongs_to :user
  has_many :items

  validates :user_id, uniqueness: true, numericality: true
end