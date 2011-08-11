class Comment < ActiveRecord::Base
    validates :description, :star, :presence => true
end
