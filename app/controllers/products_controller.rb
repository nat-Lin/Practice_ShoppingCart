class ProductsController < ApplicationController
	before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
  	@product = Product.new(product_params)

  	if @product.save
  		redirect_to products_path, notice: "新增成功"
  	else
  		render :new
  	end
  end

  def update
  	if @product.update(product_params)
  		redirect_to product_path(@product), notice: "修改成功"
  	else
  		render :edit
  	end
  end

  def destroy
  	@product.destroy
  	redirect_to products_path, notice: "商品已刪除"
  end

  def show
  end

  def edit
  end

  private
  	def product_params
  		params.require(:product).permit(:name, :description, :price)
  	end

  	def set_product
  		@product = Product.find(params[:id])
  	end
end

