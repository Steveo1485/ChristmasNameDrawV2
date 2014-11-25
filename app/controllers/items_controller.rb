class ItemsController  < ApplicationController
  before_filter :fetch_item, only: [:edit, :update, :destroy]

  def new
    @item = Item.new(list_id: current_user.list.id)
    authorize(@item)
  end

  def create
    # Update this to handle failure - render new with errors, instead of a redirect
    @item = Item.new(item_params)
    @item.list_id = current_user.list.id
    authorize(@item)
    if @item.save
      redirect_to user_root_path, notice: "Item saved to list!"
    else
      redirect_to user_root_path, alert: "Sorry, item wasn't saved."
    end
  end

  def edit
    authorize(@item)
  end

  def update
    # Update this to handle failure - render new with errors, instead of a redirect
    authorize(@item)
    if @item.update(item_params)
      redirect_to user_root_path, notice: "Item updated!"
    else
      redirect_to user_root_path, alert: "Sorry, item wasn't updated."
    end
  end

  def destroy
    # Update this to handle failure - render new with errors, instead of a redirect
    authorize(@item)
    if @item.destroy
      redirect_to user_root_path, notice: "Item deleted."
    else
      redirect_to user_root_path, alert: "Item not deleted"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :list_id)
  end

  def fetch_item
    @item = Item.find(params[:id])
  end

end