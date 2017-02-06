class CategoriesController < ApplicationController
  before_action :set_category, only:[:edit, :update, :show, :destroy]
  before_action :require_same_user, only:[:edit, :update, :destroy]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user = current_user
    if @category.save
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def index
    @categories = Category.all
  end


  def show
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to @category
    else
      render 'edit'
    end
  end
  
  def destroy
    @category.destroy
    
    redirect_to categories_path
  end

  private 

  def set_category
      @category = Category.find(params[:id])
  end

  def require_same_user
      if current_user != @category.user && !current_user.admin?
        flash[:danger] = "You can only edit your articles"
        redirect_to root_path
      end
  end


  def category_params
    params.require(:category).permit(:name, :user_id)
  end
end
