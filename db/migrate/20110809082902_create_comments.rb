class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments, :force => true  do |t|
      t.string :customer_name
      t.integer :product_id
      t.string :time
      t.integer :star
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
