class CategoriesController < ApplicationController
  before_action :set_category, only: [:destroy]

  # POST /categories
  def create
    @category = Category.create(category_params)

    if @category.save
      render json: @category, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

#   delete category
  def destroy
    @category.destroy
    render json: @category, status: 204
  end
  
    # Get a specific category
  def show
    render json: @category
  end

#   get all categories
  def index
    render json: Category.all
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
