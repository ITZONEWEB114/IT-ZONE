class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :product_id
      t.string :user_id
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
