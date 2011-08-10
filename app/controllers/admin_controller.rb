class AdminController < ApplicationController
  def index
    @total_order = Order.count
  end
end
