class ErrorsController < ApplicationController
	
	skip_before_filter :authorize
	
	def routing
		render :file => "/public/404.html", :status => 404, :layout => false
	end
end