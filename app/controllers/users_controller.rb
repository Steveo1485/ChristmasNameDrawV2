class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:facebook]
  skip_after_action :verify_authorized, only: [:facebook]
  skip_after_action :verify_policy_scoped, only: [:facebook]
  after_action :clear_facebook_session

  def facebook
    redirect_to root_path and return unless session["devise.facebook_data"].present?
    @user = User.where(provider: session["devise.facebook_data"]["provider"],
                       uid: session["devise.facebook_data"]["uid"],
                       first_name: session["devise.facebook_data"]["info"]["first_name"],
                       last_name: session["devise.facebook_data"]["info"]["last_name"],
                       email: session["devise.facebook_data"]["info"]["email"]).first_or_initialize
  end

  private

  def clear_facebook_session
    session["devise.facebook_data"].clear
  end

end