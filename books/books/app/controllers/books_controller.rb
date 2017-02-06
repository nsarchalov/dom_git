class BooksController < ApplicationController
  before_action :set_book, only:[:edit, :update, :show, :destroy]
  before_action :require_same_user, only:[:edit, :update, :destroy]

  def new
  	@book = Book.new
  end

  def create
 	@book = Book.new(book_params)
  @book.user = current_user 
    if @book.save
      upload_picture
      redirect_to @book
    else
      render 'new'
    end
  end

  def index
    @books = Book.all
    @favorite = Favorite.new
  end

  def show
  end

  def edit
  end

  def update
    if @book.update(book_params)
      upload_picture
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy

    redirect_to books_path
  end

  private

  def set_book
      @book = Book.find(params[:id])
  end

  def require_same_user
      if current_user != @book.user && !current_user.admin?
        flash[:danger] = "You can only edit your books"
        redirect_to root_path
      end
  end

  def book_params
    params.require(:book).permit(:title, :author, :year, :category_id, :user_id)
  end

  def upload_picture
  	uploaded_file = params[:book][:picture]

  	unless uploaded_file.nil?
	  new_file_path = Rails.root.join('public', 'uploads', @book.id.to_s)
	  File.open(new_file_path, 'wb') do |file|
	  file.write uploaded_file.read
	  end
	end
  end


end
