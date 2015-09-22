class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_product, only: [:show, :edit, :update, :destroy]

  def index
    respond_with(@products = Product.all)
  end

  def new
    respond_with(@product = Product.new)
  end

  def create
    respond_with(@product = Product.create(product_params.merge(store: current_user.store)))
  end

  def show
    respond_with(@product)
  end

  def edit
    respond_with(@product)
  end

  def update
    @product.update(product_params)
    respond_with(@product)
  end

  def destroy
    respond_with(@product.destroy!)
  end


  private

    def load_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :photo, :remove_photo)
    end
end
