class List < ActiveRecord::Base
  belongs_to :user
  has_many :items

  validates :user_id, uniqueness: true, numericality: true
  validates :paired_user_id, uniqueness: true, numericality: true, allow_nil: true

  default_scope { order(created_at: :asc) }
end