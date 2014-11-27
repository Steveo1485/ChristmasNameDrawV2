require 'rails_helper'

RSpec.describe AssociatedUser, :type => :model do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:owner_user_id) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:owner_user_id) }
  it { should belong_to(:user) }
end