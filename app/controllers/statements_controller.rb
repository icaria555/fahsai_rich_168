class StatementsController < ApplicationController
  before_action :set_statement, only: [:show, :edit, :update, :destroy]

  # GET /statements
  # GET /statements.json
  def index
    @statements = current_user.statements.all
    @users = User.all
    @statements.each do |statement|
      @users.find_by_id(statement.giver_id).nil?
    end
  end

  # GET /statements/1
  # GET /statements/1.json
  def show
    @users = User.all
    @statement = current_user.statements.find_by_id(params[:id])
    print @statement.products.length, params[:id], "length"
  end

  # GET /statements/new
  def new
    @products = nil
    
    if(current_user.role == Role.admin || current_user.role == Role.employee)
      @products = Product.all
    else
      @products = current_user.products
    end
    @statement = statement.new
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
    if(params[:giver_id] != "0")
      @users = User.all
      @users.each do |user|
        print user.first_name
      end
      @giver_id = params[:giver_id]
      @product_id = params[:product_id]
      @price = self.changePrice(@giver_id, @product_id)

      render json: {"price": @price, "pv": @product.pv, "element_name": params[:element_name]}
    else
      @product = Product.find_by_id(params[:product_id])
      render json: {"price": @product.price, "pv": @product.pv, "element_name": params[:element_name]}
    end
  end
  
  def pricetagfield
    print params[:product_list]
    @giver_id = params[:giver_id]
    @product_id_list = params[:product_list]
    list = []
    
    if(@giver_id != "0") 
      @user = User.find_by_id(@giver_id)
      @product_id_list.each do |product_id|
        @price = changePrice(@giver_id, product_id)
        list.push(@price)
      end
    end
    @message = {"price": list}
    render json: @message
  end
  
  def checkquantity 
  end

  # GET /statements/1/edit
  def edit
    @users = User.all
    @statement = current_user.statements.find_by_id(params[:id])
    @products = Product.all
  end

  # POST /statements
  # POST /statements.json
  def create
    statement_params.permit!
    statement_params[:receiver_id] = current_user.id
    
    params.require(:list)
    if params.has_key?(:list) and statement_params[:giver_id] != 0
      
      @statement = current_user.statements.create(statement_params)
      print @statement
      @buyer = User.find_by_id(statement_params[:giver_id])
      print @buyer.first_name , "tttttttttttttt"
      params[:list].each do |pro|
        @product = Product.find_by_id(params[:list][pro][:id])
        print @product.nil? , "product"
        @statement_product = @statement.statement_products.find_by_product_id(@product)
        
        if(@statement_product.nil?)
          @statement_product = @statement.statement_products.create(
              product: @product,
              :quantity => params[:list][pro][:quantity].to_i ,
              :total_price => params[:list][pro][:price].to_i ,
              :total_pv => params[:list][pro][:pv].to_i
            )
        else
          @statement_product.quantity += params[:list][pro][:quantity].to_i
          @statement_product.total_price += params[:list][pro][:price].to_i
          @statement_product.total_pv += params[:list][pro][:pv].to_i
        end
        
        if(current_user.role == Role.admin || current_user.role == Role.employee)
          @stock_saler = @product
          @stock_buyer = @buyer.stocks.find_by_product_id(@product)
          
          if(@stock_buyer.nil?)
            @stock_buyer = @buyer.stock.create(
                product: @product,
                :quantity => @statement_product.quantity
            )
            @stock_saler.quantity -= @statement_product.quantity
          else
            @stock_saler.quantity -= @statement_product.quantity
            @stock_buyer.quantity += @statement_product.quantity
          end
          
        else
          @stock_saler = current_user.stock.find_by_product(@product)
          @stock_buyer = @buyer.stock.find_by_product(@product)
          
          if(@stock_buyer.nil?)
            @stock_buyer = @buyer.stock.create(
                product: @product,
                :quantity => @statement_product.quantity
            )
            @stock_saler.quantity -= @statement_product.quantity
          else
            @stock_saler.quantity -= @statement_product.quantity
            @stock_buyer.quantity += @statement_product.quantity
          end
        end
      end
    end

    respond_to do |format|
      if @statement.save
        @users = User.all
        format.html { redirect_to @statement, notice: 'statement was successfully created.' }
        format.json { render :show, status: :created, location: @statement }
      else
        @products = Product.all
        print  @statement.errors.full_messages
        format.html { render :new }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statements/1
  # PATCH/PUT /statements/1.json
  def update
    statement_params.permit!
    respond_to do |format|
      if @statement.update(statement_params)
        format.html { redirect_to @statement, notice: 'statement was successfully updated.' }
        format.json { render :show, status: :ok, location: @statement }
      else
        format.html { render :edit }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statements/1
  # DELETE /statements/1.json
  def destroy
    @statement.destroy
    respond_to do |format|
      format.html { redirect_to statements_url, notice: 'statement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statement
      @statement = statement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def statement_params
      params.require(:statement).permit(:giver_id, :receiver_id, :total_price, :total_pv)
      params.fetch(:statement, {})
    end
end
