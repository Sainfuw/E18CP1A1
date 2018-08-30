class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :sale]
  before_action :authenticate_user?, except: [:index, :show]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    if !@product.owner?(current_user)
      redirect_to root_path, alert: 'No tiene autorizacion para esta accion.'
    end
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, alert: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, alert: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    if !@product.owner?(current_user)
      redirect_to root_path, alert: 'No tiene autorizacion para esta accion.'
    end
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, alert: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sale
    # @purchase = Purchase.new(user_id: current_user.id, name: @product.name, price: @product.price)
    # @purchase.save
    @product.destroy
    redirect_to products_url, alert: 'Producto comprado con éxito'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :price)
    end
end
