require 'rails_helper'

RSpec.describe ItemsController, :type => :controller do

  before :each do
    @user = FactoryGirl.create(:user)
    @item_build = FactoryGirl.build(:item, list: @user.list)
    @item = FactoryGirl.create(:item, list: @user.list)
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

  describe "GET #new" do
    it "should render the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "should render the edit template" do
      get :edit, id: @item.id
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    it "should update an item with valid attributes" do
      patch :update, id: @item.id, item: {name: "iPhone 6"}
      expect(@item.reload.name).to eq("iPhone 6")
    end

    it "shouldn't update an item with invalid attributes" do
      starting_name = @item.name
      patch :update, id: @item.id, item: {name: ""}
      expect(@item.reload.name).to eq(starting_name)
    end

    it "shouldn't allow a user to update an item not tied to their own list" do
      other_user = FactoryGirl.create(:user)
      other_item = FactoryGirl.create(:item, list: other_user.list)
      patch :update, id: other_item.id, item: {name: "iPhone 6"}
      expect(@item.reload.name).to_not eq("iPhone 6")
    end
  end

  describe "DELETE #destroy" do
    it "should destroy an item tied to the current user" do
      expect{ delete :destroy, id: @item.id }.to change(Item, :count).by(-1)
    end

    it "shouldn't destroy an item not tied to the current user" do
      other_user = FactoryGirl.create(:user)
      other_item = FactoryGirl.create(:item, list: other_user.list)
      expect{ delete :destroy, id: other_item.id }.to_not change(Item, :count)
    end
  end

end