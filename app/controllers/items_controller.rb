class ItemsController  < ApplicationController
  before_filter :fetch_item, only: [:edit, :update, :destroy]

  def new
    @item = Item.new(list_id: current_user.list.id)
    authorize(@item)
  end

  def create
    @item = Item.new(item_params)
    authorize(@item)
    if @item.save
      redirect_to user_root_path(user_id: @item.list.user_id), notice: "Item saved to list!"
    else
      render :new
    end
  end

  def edit
    authorize(@item)
  end

  def update
    authorize(@item)
    if @item.update(item_params)
      redirect_to user_root_path(user_id: @item.list.user_id), notice: "Item updated!"
    else
      render :edit
    end
  end

  def destroy
    authorize(@item)
    if @item.destroy
      flash[:notice] = "Item removed from list."
    else
      flash[:alert] = "Sorry, item not deleted. Please try again."
    end
    redirect_to user_root_path(user_id: @item.list.user_id)
  end

  private

  def item_params
    params.require(:item).permit(:name, :url, :notes, :list_id)
  end

  def fetch_item
    @item = Item.find(params[:id])
  end

end