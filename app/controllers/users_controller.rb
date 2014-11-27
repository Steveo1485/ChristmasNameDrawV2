class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:facebook]
  skip_after_action :verify_authorized, only: [:facebook]
  skip_after_action :verify_policy_scoped, only: [:facebook]
  after_action :clear_facebook_session, only: [:facebook]

  def new
    @user = User.new
    authorize(@user)
  end

  def create
    @user = User.new(user_params)
    authorize(@user)
    validation_passed = true
    User.transaction do
      begin
        @user.password = Devise.friendly_token[0,20]
        @user.save!
        AssociatedUser.create(owner_user_id: current_user.id, user_id: @user.id)
      rescue ActiveRecord::RecordInvalid => error
        validation_passed = false
        raise ActiveRecord::Rollback
      end
    end
    if validation_passed
      redirect_to user_root_path, notice: "Associated user successfully created!"
    else
      render :new
    end
  end

  def dashboard
    if params[:associated_user_id]
      @user = User.find(params[:associated_user_id])
    else
      @user = current_user
    end
    authorize(@user)
    @item = Item.new
  end

  def facebook
    redirect_to root_path and return unless session["devise.facebook_data"].present?
    @user = User.where(provider: session["devise.facebook_data"]["provider"],
                       uid: session["devise.facebook_data"]["uid"],
                       first_name: session["devise.facebook_data"]["info"]["first_name"],
                       last_name: session["devise.facebook_data"]["info"]["last_name"],
                       email: session["devise.facebook_data"]["info"]["email"]).first_or_initialize
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :family_group, :email, :password)
  end

  def clear_facebook_session
    session["devise.facebook_data"].clear
  end

end