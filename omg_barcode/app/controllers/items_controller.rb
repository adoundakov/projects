class ItemsController < ApplicationController
  def new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
    else
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :upc)
  end
end
