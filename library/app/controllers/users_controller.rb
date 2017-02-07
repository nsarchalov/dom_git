class UsersController < ApplicationController
  before_action :set_user, only:[:edit, :update]
  before_action :require_same_user, only:[:edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
    @favorites = Favorite.all
  end

  # GET /users/1
  def show
    @nurlan = Favorite.all
  end

  def favorite
    @favorite = Favorite.new
    @favorite.book_id = params[:book_id]
    @favorite.user = params[:user_id]
    @favorite.save
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def require_same_user
      if current_user != @user
        flash[:danger] = "You can only edit your article"
        redirect_to root_path
      end
    end
    
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
