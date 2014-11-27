class ListsController < ApplicationController
  http_basic_authenticate_with :name => ENV["PAIRING_NAME"], :password => ENV['PAIRING_PASSWORD'] if (Rails.env.production? or Rails.env.development?)

  skip_before_action :authenticate_user!, only: [:index, :update]
  skip_after_action :verify_policy_scoped, only: :index
  skip_after_action :verify_authorized,  only: :update

  def index
    redirect_to root_path if current_user
    @lists = List.all
  end

  def update
    validation_passed = true
    List.transaction do
      begin
        lists_params.each do |list_id, paired_user_id|
          List.find(list_id).update!(paired_user_id: paired_user_id)
        end
      rescue ActiveRecord::RecordInvalid => error
        validation_passed = false
        raise ActiveRecord::Rollback
      end
    end
    if validation_passed
      flash[:notice] = "Lists successfully updated!"
    else
      flash[:danger] = "Something went wrong. Please try again."
    end
    redirect_to lists_path
  end

  private

  def lists_params
    params.require(:lists)
  end

end