class CategoriesController < ApplicationController

  def subcategories
    category = Category.find(params[:id])
    render json: category.subcategories.select(:id, :name)
  end
end
