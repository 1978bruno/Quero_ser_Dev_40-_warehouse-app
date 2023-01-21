class ProductModelsController < ApplicationController
  def index
    @product_model = ProductModel.all
  end
end