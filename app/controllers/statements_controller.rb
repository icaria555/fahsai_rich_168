class StatementsController < ApplicationController
  before_action :set_statement, only: [:show, :edit, :update, :destroy]

  # GET /statements
  # GET /statements.json
  def index
    @statements = Statement.all
    @users = User.all
    @statements.each do |statement|
      @users.find_by_id(statement.purchaser_id).nil?
    end
  end

  # GET /statements/1
  # GET /statements/1.json
  def show
    @users = User.all
    @statement = current_user.statements.find_by_id(params[:id])
  end

  # GET /statements/new
  def new
    @products = Product.all
    @statement = Statement.new
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
    statement_params[:saler_id] = current_user.id
    
    params.require(:list)
    if params.has_key?(:list) and statement_params[:purchaser_id] != 0
      @statement = current_user.statements.create(statement_params)
      params[:list].each do |pro|
        @product = Product.find_by_id(params[:list][pro][:id])
        @test = @statement.statement_products.create(
            product: @product,
            :quantity => params[:list][pro][:quantity].to_i ,
            :total_price => params[:list][pro][:price].to_i ,
            :total_pv => params[:list][pro][:pv].to_i
          )
      end
    end

    respond_to do |format|
      if @statement.save
        format.html { redirect_to @statement, notice: 'Statement was successfully created.' }
        format.json { render :show, status: :created, location: @statement }
      else
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
        format.html { redirect_to @statement, notice: 'Statement was successfully updated.' }
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
      format.html { redirect_to statements_url, notice: 'Statement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statement
      @statement = Statement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def statement_params
      params.fetch(:statement, {})
    end
end
