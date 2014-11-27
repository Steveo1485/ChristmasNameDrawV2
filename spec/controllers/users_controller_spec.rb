require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  before :each do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET #dashboard" do
    it "should render the dashboard template" do
      get :dashboard
      expect(response).to render_template(:dashboard)
    end

    it "should assign current_user" do
      get :dashboard
      expect(assigns[:user].id).to eq(@user.id)
    end
  end

  describe "GET #new" do
    it "should render the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    before :each do
      @build_user = FactoryGirl.build(:user)
    end

    it "should create a new user with valid attributes" do
      expect{ post :create, user: @build_user.attributes }.to change(User, :count).by(1)
    end

    it "should create a new associated user" do
      expect{ post :create, user: @build_user.attributes }.to change(AssociatedUser, :count).by(1)
    end

    it "should not create a new user with invalid attributes" do
      expect{ post :create, user: {first_name: @build_user.attributes[:first_name]} }.to_not change(User, :count)
    end

    it "should not create a new associated user with invalid attributes" do
      expect{ post :create, user: {first_name: @build_user.attributes[:first_name]} }.to_not change(AssociatedUser, :count)
    end
  end

end