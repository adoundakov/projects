class Api::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      success = ['Item Saved Successfully']
      render json: success, status: 200
    else
      errors = @item.errors.full_messages
      render json: errors, status: 422
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :upc)
  end
end
