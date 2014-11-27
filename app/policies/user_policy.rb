class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def new?
    @user
  end

  def create?
    @user
  end

  def dashboard?
    @user == @record or @user.associated_users.pluck(:owner_user_id).include?(@user.id)
  end

end