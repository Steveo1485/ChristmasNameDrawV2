require 'rails_helper'

RSpec.describe Item, :type => :model do
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:list_id) }
  it { should belong_to(:list) }
end