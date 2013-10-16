class CategoriesController < ApplicationController
  def index
        @categories = Category.all
  end

  def show
        @category = Category.find_by_name(params[:id])
        @posts = @category.posts.all
  end
end