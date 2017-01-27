class ItemsController < ApplicationController # :nodoc:
  def new
    # render new item form
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = ['Item Saved Successfully']
      redirect_to new_item_url
    else
      flash.now[:errors] = @item.errors.full_messages
      render :new, status: 422
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :upc)
  end
end
