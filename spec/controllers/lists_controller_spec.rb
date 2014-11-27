require 'rails_helper'

RSpec.describe ListsController, :type => :controller do

  before :each do
    @user = FactoryGirl.create(:user)
    @second_user = FactoryGirl.create(:user)
  end

  describe "GET #index" do
    it "should render the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "should assign all lists" do
      get :index
      expect(assigns[:lists].pluck(:id)).to eq([@user.list.id, @second_user.list.id])
    end

    it "should redirect to root if user signed in" do
      sign_in @user
      get :index
      expect(response).to redirect_to(root_path)
    end
  end

  describe "PATCH #update" do
    before :each do
      @third_user = FactoryGirl.create(:user)
      @fourth_user = FactoryGirl.create(:user)

      @list_one = @user.list
      @list_two = @second_user.list
      @list_three = @third_user.list
      @list_four = @fourth_user.list
    end

    it "should update all valid lists with paired_user_id" do
      params = {@list_one.id => @second_user.id,
                @list_two.id => @third_user.id,
                @list_three.id => @fourth_user.id,
                @list_four.id => @user.id}

      patch :update, lists: params

      expect(@list_one.reload.paired_user_id).to eq(@second_user.id)
      expect(@list_two.reload.paired_user_id).to eq(@third_user.id)
      expect(@list_three.reload.paired_user_id).to eq(@fourth_user.id)
      expect(@list_four.reload.paired_user_id).to eq(@user.id)
    end

    it "should not update any lists if any list pairing is invalid" do
      params = {@list_one.id => @second_user.id,
                @list_two.id => @third_user.id,
                @list_three.id => @second_user.id,
                @list_four.id => @user.id}

      patch :update, lists: params

      expect(@list_one.reload.paired_user_id).to eq(nil)
      expect(@list_two.reload.paired_user_id).to eq(nil)
      expect(@list_three.reload.paired_user_id).to eq(nil)
      expect(@list_four.reload.paired_user_id).to eq(nil)
    end
  end

end