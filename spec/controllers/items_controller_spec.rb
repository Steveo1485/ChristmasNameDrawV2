require 'rails_helper'

RSpec.describe ItemsController, :type => :controller do

  before :each do
    @user = FactoryGirl.create(:user)
    @item_build = FactoryGirl.build(:item, list: @user.list)
    sign_in @user
  end

  describe "POST #create" do
    it "should create an Item with valid attributes" do
      expect{ post :create, item: {name: @item_build.name, list_id: @item_build.list_id} }.to change(Item, :count).by(1)
    end

    it "should not create an Item with invalid attributes" do
      expect{ post :create, item: {list_id: @item_build.list_id} }.to_not change(Item, :count)
    end

    it "should not allow an Item to be created for a list that doesn't belong to the user" do
      other_user = FactoryGirl.create(:user)
      expect{ post :create, item: {name: @item_build.name, list_id: other_user.list.id} }.to_not change(Item, :count)
    end
  end

end