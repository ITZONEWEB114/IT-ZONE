class OrdersController < ApplicationController
  before_filter :customer_authorize, :only => [:new, :create, :present]
  skip_before_filter :authorize, :only => [:new, :create, :present]
  
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
		is_buyer=(@order.customer_id == (current_customer.id.to_i))

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
			redirect_to store_url, :notice => "Your cart is empty"
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
		@customer = Customer.find(@order.customer_id||params[:customer_id])
		flash[:true_if_editing_false_if_shipping] = true
  end

  # POST /orders
  # POST /orders.xml
  def create
		@customer = current_customer
    @order = Order.new(params[:order].merge!({:customer_id => @customer.id}))
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
		@state, @path_to, flash[:notice] = flash[:true_if_editing_false_if_shipping] ? \
			["Amended", orders_path, 'Order was successfully updated.' ] \
			: \
			["Shipped", ship_orders_path(:previous_id => @order.id), 'Order was successfully shipped.']
    respond_to do |format|
      if @order.update_attributes(params[:order])
				Notifier.order_shipped(@order, @state).deliver
        format.html { redirect_to @path_to }
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
		unless @order = Order.find( :first, :conditions => [ "id > :id and shipped = :false", {:id=>(params[:previous_id] || (Order::ID_STARTED_AT-1)), :false => false}])
			redirect_to orders_path, :notice => "No unshipped orders found."
		else
			@customer = Customer.find(@order.customer_id)
			flash[:true_if_editing_false_if_shipping] = false
		end
	end
		
end