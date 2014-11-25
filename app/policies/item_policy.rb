class ItemPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def new?
    @user.list.id == @record.list_id
  end

  def create?
    new?
  end

  def edit?
    @user.list.id == @record.list_id
  end

  def update?
    edit?
  end

  def destroy?
    @user.list.id == @record.list_id
  end

end