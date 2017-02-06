class FavoritesController < ApplicationController
  before_action :set_favorite, only: [:show, :edit, :update, :destroy]

  # GET /favorites
  def index
    @favorites = Favorite.all
  end

  # GET /favorites/1
  def show
  end

  # GET /favorites/new
  def new
  end

  # GET /favorites/1/edit
  def edit
  end

  # POST /favorites
  def create
    @favorite = Favorite.new(favorite_params)
    @favorite.user = current_user
    if @favorite.save
      redirect_to @favorite, notice: 'Favorite was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /favorites/1
  def update
    if @favorite.update(favorite_params)
      redirect_to @favorite, notice: 'Favorite was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /favorites/1
  def destroy
    @favorite.destroy
    redirect_to favorites_url, notice: 'Favorite was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def favorite_params
      params.require(:favorite).permit(:id, :user_id, :book_id)
    end
end
