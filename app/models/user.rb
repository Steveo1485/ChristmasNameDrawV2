class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :family_group, inclusion: { in: Proc.new { User.family_groups } }

  def self.family_groups
    ["Dragseth", "King", "Nugent"]
  end
end