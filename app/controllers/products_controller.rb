class ProductsController < ApplicationController
  before_action :load_product, only: :show

  def new
    respond_with(@product = Product.new)
  end

  def create
    respond_with(@product = Product.create(product_params))
  end

  def show
    respond_with(@product)
  end


  private

    def load_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :photo)
    end
end
