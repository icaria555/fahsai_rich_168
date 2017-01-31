class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    if(current_user.role.name != "admin" and current_user.role.name != "employee" )
      @orders = Order.find_by_saler_id(current_user.id)
    end
    @users = User.all
    @orders.each do |order|
      @users.find_by_id(order.purchaser_id).nil?
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @users = User.all
    @order = Order.find_by_id(params[:id])
    #print @order.products.length, params[:id], "length"
  end

  # GET /orders/new
  def new
    @products = nil
    
    if(current_user.role == Role.admin || current_user.role == Role.employee)
      @products = Product.all
    else
      @products = current_user.products
    end
    @order = Order.new
  end
  
  def changePrice(user_id, product_id)
    @user = User.find_by_id(user_id)
    @role = @user.role
    @product = Product.find_by_id(product_id)
    @discount = @role.discounts.find_by_product_id(@product)
    if(@discount.nil?)
      return @price = @product.price
    else
      return @price = (@product.price - @discount.amount).to_i
    end
  end
  
  def pricetagselect
    if(params[:purchaser_id] != "0")
      @users = User.all
      @users.each do |user|
        print user.first_name
      end
      @purchaser_id = params[:purchaser_id]
      @product_id = params[:product_id]
      @price = self.changePrice(@purchaser_id, @product_id)

      render json: {"price": @price, "pv": @product.pv, "element_name": params[:element_name]}
    else
      @product = Product.find_by_id(params[:product_id])
      render json: {"price": @product.price, "pv": @product.pv, "element_name": params[:element_name]}
    end
  end
  
  def pricetagfield
    print params[:product_list]
    @purchaser_id = params[:purchaser_id]
    @product_id_list = params[:product_list]
    list = []
    
    if(@purchaser_id != "0") 
      @user = User.find_by_id(@purchaser_id)
      @product_id_list.each do |product_id|
        @price = changePrice(@purchaser_id, product_id)
        list.push(@price)
      end
    end
    @message = {"price": list}
    render json: @message
  end
  
  def checkquantity 
  end

  # GET /orders/1/edit
  def edit
    @users = User.all
    @order = Order.find_by_id(params[:id])
    @products = Product.all
  end

  # POST /orders
  # POST /orders.json
  def create
    order_params.permit!
    order_params[:saler_id] = current_user.id
    
    params.require(:list)
    if params.has_key?(:list) and order_params[:purchaser_id] != 0
      
      @order = Order.create(order_params)
      print @order.errors.full_messages
      @buyer = User.find_by_id(order_params[:purchaser_id])
      print @buyer.first_name , "tttttttttttttt"
      
      params[:list].each do |pro|
        @product = Product.find_by_id(params[:list][pro][:id])
        print @product.nil? , "product"
        @order_product = @order.order_products.find_by_product_id(@product)
        
        if(@order_product.nil?)
          @order_product = @order.order_products.create(
              product: @product,
              :quantity => params[:list][pro][:quantity].to_i ,
              :total_price => params[:list][pro][:price].to_i ,
              :total_pv => params[:list][pro][:pv].to_i
            )
        else
          @order_product.quantity += params[:list][pro][:quantity].to_i
          @order_product.total_price += params[:list][pro][:price].to_i
          @order_product.total_pv += params[:list][pro][:pv].to_i
        end
        
        if(current_user.role == Role.admin || current_user.role == Role.employee)
          @stock_saler = @product
          @stock_buyer = @buyer.stocks.find_by_product_id(@product)
          
          if(@stock_buyer.nil?)
            @stock_buyer = @buyer.stock.create(
                product: @product,
                :quantity => @order_product.quantity
            )
            @stock_saler.quantity -= @order_product.quantity
          else
            @stock_saler.quantity -= @order_product.quantity
            @stock_buyer.quantity += @order_product.quantity
          end
          
        else
          @stock_saler = current_user.stock.find_by_product(@product)
          @stock_buyer = @buyer.stock.find_by_product(@product)
          
          if(@stock_buyer.nil?)
            @stock_buyer = @buyer.stock.create(
                product: @product,
                :quantity => @order_product.quantity
            )
            @stock_saler.quantity -= @order_product.quantity
          else
            @stock_saler.quantity -= @order_product.quantity
            @stock_buyer.quantity += @order_product.quantity
          end
        end
      end
    end

    respond_to do |format|
      if @order.save
        @users = User.all
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        @products = Product.all
        print  @order.errors.full_messages
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    order_params.permit!
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:purchaser_id, :saler_id, :total_price, :total_pv)
      params.fetch(:order, {})
    end
end
