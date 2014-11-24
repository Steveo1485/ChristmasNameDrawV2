class AboutController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_filter :verify_authorized
  skip_after_filter :verify_policy_scoped

  def home
    redirect_to user_root_path if current_user
  end

end