class OrdersController < ApplicationController

  #skip_before_filter :authorize, :only => [:new, :create]
	
  # GET /orders
  # GET /orders.xml
  def index
    #@orders = Order.all
	@orders = Order.paginate :page => params[:page], :order => 'created_at asc', :per_page => 10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end
	
  # GET /orders/1/present
  def present
    @order = Order.find(params[:id])
		is_buyer=(@order.user_id == (current_user.id.to_i))

		if is_buyer
			respond_to do |format|
				format.html # present.html.erb
			end
		else
			redirect_to store_path, :notice => "You are not the owner of that order"
		end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
		if (@cart=current_cart).line_items.empty?
			redirect_to store_url, :notice => "Your cart is empty."
			return
		end
  
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
		@user = current_user
    @order = Order.new(params[:order].merge!({:user_id => @user.id}))
		@order.add_line_items_from_cart(current_cart)
	
    respond_to do |format|
      if @order.save
				Cart.destroy(session[:cart_id])
				session[:cart_id] = nil
				Notifier.order_received(@order).deliver
        format.html { redirect_to(store_url, :notice => I18n.t('.thanks')) }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
				Notifier.order_shipped(@order).deliver
        format.html { redirect_to(ship_orders_path(:previous_id => @order.id), :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
	
	def ship
		unless @unshipped_order = Order.find( :first, :conditions => [ "id > :id and shipped = FALSE", {:id=>(params[:previous_id] || (Order::ID_STARTED_AT-1))}])
			redirect_to orders_path, :notice => "No unshipped orders found."
		end
		@user = User.find(@unshipped_order.user_id)
	end
		
end
