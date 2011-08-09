class AdminController < ApplicationController
  skip_before_filter :customer_authorize
  def index
    @total_order = Order.count
  end
end
