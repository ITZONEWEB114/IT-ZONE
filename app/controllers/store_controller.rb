class StoreController < ApplicationController
  def index
	@products, @isAll, flash[:notice] = Product.getProducts params
	@cart = current_cart
  end

end
