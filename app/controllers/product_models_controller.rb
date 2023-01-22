class ProductModelsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    @product_model = ProductModel.all
  end
  def new
    @product_model = ProductModel.new
    @supplier = Supplier.all
  end
  def create
    @product_model = ProductModel.new
    product_model_params = params.require(:product_model).permit(:name, :height, :width, :depht,
                                                                :weight, :sku, :supplier_id)
    @product_model = ProductModel.new(product_model_params)
    @product_model.save
    redirect_to @product_model, notice: 'Modelo de produto cadastrado com sucesso.'
  end
  def show
    @product_model = ProductModel.find(params[:id])
  end
end