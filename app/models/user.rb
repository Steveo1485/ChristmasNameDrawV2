class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]

  has_one :list
  has_one :associated_owner, class_name: AssociatedUser, foreign_key: :user_id
  has_many :associated_users, foreign_key: :owner_user_id

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :family_group, inclusion: { in: Proc.new { User.family_groups } }
  validates :email, presence: true

  after_create :create_list

  def self.family_groups
    ["Dragseth", "King", "Nugent"]
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
    end
  end

  def name
    [first_name, last_name].join(" ")
  end

  # Devise - Allow Duplicate Emails
  def email_required?
    false
  end

  def email_changed?
    false
  end

  private

  def create_list
    list = List.where(user_id: self.id).first_or_initialize
    list.save if list.new_record?
  end

end