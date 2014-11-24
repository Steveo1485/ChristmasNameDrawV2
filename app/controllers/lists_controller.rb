class ListsController < ApplicationController

  def create
    @list = List.new(user_id: current_user.id)
    if @list.save
      flash[:notice] = "List created. You can now add items."
    else
      flash[:alert] = "Unable to create list. Please try again."
    end
    redirect_to user_root_path
  end

end