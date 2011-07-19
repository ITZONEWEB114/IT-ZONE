class Product < ActiveRecord::Base

	default_scope :order => 'title'
	has_many :line_items
	
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
	
	
	validates :title, :description, :image_url, :presence => true
	
	validates :price, :numericality => {:greater_than_or_equal_to => 0.01 }
	
	validates :title, :uniqueness => true
	
	validates :image_url, :format => {
		:with		=> %r{\.(gif|jpg|png)$}i,
		:message	=> 'must be a URL for GIF, JPG or PNG image.'
	}
end
