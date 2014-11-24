require 'rails_helper'

RSpec.describe ListsController, :type => :controller do

  before :each do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "POST #create" do
    it "should create a list with valid attributes" do
      expect{ post :create, list: {user_id: @user.id} }.to change(List, :count).by(1)
    end

    it "should now create a list of user already has one" do
      FactoryGirl.create(:list, user: @user)
      expect{ post :create, list: {user_id: @user.id} }.to_not change(List, :count)
    end
  end

end