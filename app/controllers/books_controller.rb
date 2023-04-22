class BooksController < ApplicationController
   protect_from_forgery
   
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(book.id)
  end
  
  def index
    @books = Book.all
  end

  def show
    @books = Book.find(params[:id])
  end

  def edit
  end

  def destroy
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end