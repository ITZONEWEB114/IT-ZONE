class ErrorsController < ApplicationController
	def routing
		render :file => "/public/404.html", :status => 404, :layout => false
	end
end