class AssociatedUser < ActiveRecord::Base
  validates :user_id, presence: true
  validates :owner_user_id, presence: true
  validates :user_id, uniqueness: { scope: :owner_user_id }

  belongs_to :user
end