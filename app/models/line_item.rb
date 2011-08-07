class LineItem < ActiveRecord::Base
  
  def total_price
    product.price * quantity
  end
  
  belongs_to :order
  belongs_to :product
  belongs_to :cart
end