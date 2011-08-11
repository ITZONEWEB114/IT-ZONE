class Comment < ActiveRecord::Base
	belongs_to :product
	belongs_to :user
	
	validates :title, :content, :presence => true
end
