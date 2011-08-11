class AddColumnsToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :customer_id, :integer
    add_column :orders, :shipped, :boolean, :default => false
    add_column :orders, :ship_date, :date
    add_column :orders, :express_company, :string
    add_column :orders, :express_number, :string
  end

  def self.down
    remove_column :orders, :express_number
    remove_column :orders, :express_company
    remove_column :orders, :ship_date
    remove_column :orders, :shipped
    remove_column :orders, :customer_id
  end
end
