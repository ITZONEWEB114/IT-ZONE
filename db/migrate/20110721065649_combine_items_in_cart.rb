class CombineItemsInCart < ActiveRecord::Migration
  def self.up
    Cart.all.each do |cart|
      sums = cart.line_items.group(:product_id).sum(:quantity)
      sums.each do |product_id, quantity|
        if quantity > 1
          cart.line_items.where(:product_id=>product_id).delete_all
          cart.line_items.create(:product_id=>product_id, :quantity=>quantity)
        end
      end
    end
  end

  def self.down
    LineItem.where("quantity>1" ).each do |lineitem|
      lineitem.quantity.times do
        LineItem.create :cart_id=>lineitem.cart_id,
        :product_id=>lineitem.product_id, :quantity=>1
      end
      lineitem.destroy
    end
  end
end
