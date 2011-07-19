# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
Product.delete_all

Product.create( :title => "The Ruby Programming Language 1.9",
				:description => "description here.",
				:image_url => "/images/ruby.jpg",
				:price => 4.6)
Product.create( :title => "The Ruby Testing",
				:description => "description here.",
				:image_url => "/images/rtp.jpg",
				:price => 43.6)