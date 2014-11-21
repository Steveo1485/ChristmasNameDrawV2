require 'rails_helper'

RSpec.describe AboutController, :type => :controller do

  describe "GET #home" do
    it "should render the home template" do
      get :home
      expect(response).to render_template(:home)
    end
  end

end