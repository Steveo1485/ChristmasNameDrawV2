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

end