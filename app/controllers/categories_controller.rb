class CategoriesController < ApplicationController
  def index
    @category_parent = Category.where(ancestry: nil)
  end

  def show
  end
end