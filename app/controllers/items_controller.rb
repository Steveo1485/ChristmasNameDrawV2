class ItemsController  < ApplicationController

  def create
    # Update this to handle failure - render new with errors, instead of a redirect
    @item = Item.new(item_params)
    authorize(@item)
    if @item.save
      redirect_to user_root_path, notice: "Item saved to list!"
    else
      redirect_to user_root_path, alert: "Sorry, item wasn't saved"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :list_id)
  end

end