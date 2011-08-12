class AddNewAttributionToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :author, :string
    add_column :products, :publisher, :string
    add_column :products, :page, :interger
    add_column :products, :ISBN, :string
  end

  def self.down
    remove_column :products, :ISBN
    remove_column :products, :page
    remove_column :products, :publisher
    remove_column :products, :author
  end
end
