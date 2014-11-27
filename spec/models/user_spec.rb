require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should ensure_inclusion_of(:family_group).in_array(["Dragseth", "King", "Nugent"]) }
  it { should have_many(:associated_users) }
  it { should have_one(:associated_owner) }

  it "should create a list for user after create" do
    @user = FactoryGirl.create(:user)
    expect(@user.list).to be_valid
  end
end