require 'rails_helper'

RSpec.describe List, :type => :model do
  it { should validate_numericality_of(:user_id) }
  it { should validate_uniqueness_of(:user_id) }
  it { should belong_to(:user) }
  it { should have_many(:items) }
end