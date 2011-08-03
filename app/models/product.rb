class Product < ActiveRecord::Base

	default_scope :order => 'title'
	has_many :line_items
	has_many :orders, :through => :line_items
	
	CATEGORIES = [ "Default",		"Arts & Photography", "Audiobooks", "Audible Audiobooks", "Biographies & Memoirs", "Business & Investing", "Calendars", "Children's Books", "Christian Books", "Comics & Graphic Novels", "Computers & Internet", "Cooking, Food & Wine", "Crafts & Hobbies", "Entertainment", "Gay & Lesbian", "Health, Mind & Body", "History", "Home & Garden", "Literature & Fiction", "Mystery & Thrillers", "Nonfiction", "Outdoors & Nature", "Parenting & Families", "Politics", "Professional & Technical", "Puzzles & Games", "Rare & Collectible Books", "Reference", "Religion & Spirituality", "Romance", "Science", "Science Fiction & Fantasy", "Self-Help", "Sports", "Teens", "Textbooks", "Travel" ]
	
	
	before_destroy :ensure_not_referenced_by_any_line_item
	# ensure that there  are no line items referencing thsi product
	def ensure_not_referenced_by_any_line_item
		if line_items.count.zero?
			return true
		else
			errors[:base] << "Line Items persent"
			return false
		end
	end
	
	def self.getProducts params=[]
		
		def self.needAllProducts a_notice=nil
			@products = Product.all
			@isAll = true
			@notice = a_notice
		end
		
		isAll = false
		if params[:category]
			if CATEGORIES.include? params[:category]
				@products = Product.find_all_by_category params[:category]
				if @products.empty?
					needAllProducts "No products of category \"#{params[:category]}\" found."
				end
			else
				needAllProducts "Category \"#{params[:category]}\" doesn't exists."
			end
		else
			needAllProducts
		end
		return @products, @isAll, @notice
	end
	
	validates :title, :description, :image_url, :presence => true
	
	validates :category, :inclusion => CATEGORIES
	
	validates :price, :numericality => {:greater_than_or_equal_to => 0.01 }
	
	validates :title, :uniqueness => true
	
	validates :image_url, :format => {
		:with		=> %r{\.(gif|jpg|png)$}i,
		:message	=> 'must be a URL for GIF, JPG or PNG image.'
	}
end
