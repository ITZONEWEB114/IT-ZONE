class AddColumnToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :category, :string, :default => "Default"
  end

  def self.down
    remove_column :products, :category
  end
end
