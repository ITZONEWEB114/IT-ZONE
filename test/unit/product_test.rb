require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
	test "product attributes must not be empty" do
		product = Product.new
		assert product.invalid?
		assert product.errors[:title].any?
		assert product.errors[:description].any?
		assert product.errors[:price].any?
		assert product.errors[:image_url].any?
	end
	
	test "product price must be positive" do
		product = Product.new(	:title			=> "My Book Title",
								:description	=> "description",
								:image_url		=> "image.jpg")
		product.price = -1
		assert product.invalid?
		assert_equal "must be greater than or equal to 0.01",
			product.errors[:price].join('; ')
			
		product.price = 0
		assert product.invalid?
		assert_equal "must be greater than or equal to 0.01",
			product.errors[:price].join('; ')
			
		product.price = 1
		assert product.valid?
	end
	
	def new_product(image_url)
		Product.new(	:title			=> "Title",
						:description	=> "Description",
						:price			=> 1,
						:image_url		=> image_url)
	end
	
	test "image url" do
		ok = %w{ fred.gif gred.jpg f.png F.JPG F.Jpg
					http://a.b.c/x/y/z/f.gif }
		bad = %w{ fred.doc f.gif/more f.gif.more }
		
		ok.each do |name|
			assert new_product(name).valid?, "#{name} shouldn't be invalid"
		end
		
		bad.each do |name|
			assert new_product(name).invalid?, "#{name} shouldn't be valid"
		end
	end
	
	test "product is not valid without a unique title" do
		product = Product.new(	:title			=> products(:ruby).title,
								:description	=> "yyy",
								:price			=> 1,
								:image_url		=> "fred.gif")
		assert !product.save
		assert_equal "has already been taken", product.errors[:title].join('; ')
	end
					
end
