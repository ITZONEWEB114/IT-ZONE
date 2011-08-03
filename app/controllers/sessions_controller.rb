class SessionsController < ApplicationController
  
  skip_before_filter :authorize
  
  
  def new
		flash.keep :backtrack_path
  end

  def create
		if user = User.authenticate(params[:name], params[:password])
			session[:user_id] = user.id
			@passed = true
		else
			@passed = false
			flash.keep :backtrack_path
		end
		if flash[:backtrack_path]
			@url_to = flash[:backtrack_path]
		else
			@url_to = admin_url
		end
		
		respond_to do |format|
				if @passed
					format.html { redirect_to(@url_to) }
					format.js
					format.xml  { head :ok } #format.xml的东西我乱写的,可以无视
				else
					format.html { redirect_to login_url, :alert => "Invalid user/password combination" }
					format.js
					format.xml  { render :status => 422 }
				end
		end
  end

  def destroy
		session[:user_id] = nil
		redirect_to store_url, :notice => "Logged out"
  end

end
