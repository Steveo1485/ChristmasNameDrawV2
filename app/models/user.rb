class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :family_group, inclusion: { in: Proc.new { User.family_groups } }

  def self.family_groups
    ["Dragseth", "King", "Nugent"]
  end
end