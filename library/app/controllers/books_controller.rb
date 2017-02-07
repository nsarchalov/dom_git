class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only:[:edit, :update, :destroy]
  # GET /books
  def index
    @books = Book.all
  end

  # GET /books/1
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create
    @book = Book.new(book_params)
    @book.user = current_user if logged_in?
    if @book.save
      upload_picture
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render 'new'
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render 'edit'
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    def require_same_user
      if current_user != @book.user && !current_user.admin?
        flash[:danger] = "You can only edit your books"
        redirect_to root_path
      end
    end

    # Only allow a trusted parameter "white list" through.
    def book_params
      params.require(:book).permit(:name, :author, :year)
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
