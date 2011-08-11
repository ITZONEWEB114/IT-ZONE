class CommentsController < ApplicationController
   skip_before_filter :authorize
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new
    @product = Product.find(params[:product_id])
    if session[:customer_id]
      @customer = Customer.find(session[:customer_id])
      login=true
      has_bought=false
      @orders = Order.where(:customer_id=>@customer)
      for order in @orders
        if order.shipped==true
           for item in order.line_items
              if item.product.id==@product.id
                has_bought=true;
              end
            end
         end
       end
     else
      login=false
    end  
   
    respond_to do |format|
      if login && has_bought
        format.html # new.html.erb
        format.xml  { render :xml => @comment }
      else
        if !login
          format.html {redirect_to(show_product_url(:product_id=>@product), :alert=>'Dear,please login!')}   
        else
          format.html {redirect_to(show_product_url(:product_id=>@product), :alert=>'You can not put a comment before you read it and buy it from here.')}
        end
      end
    end
   end
   
  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to(store_url, :notice => 'Comment was successfully created.') }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
  

end
