class BooksController < ApplicationController
   protect_from_forgery

  def new
    @book = Book.new
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :show
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @books = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    unless @user.id == current_user.id
      redirect_to books_path
    end
  end

   def update
    @book = Book.find(params[:id])
    @user = @book.user
      if @book.update(book_params)
        flash[:notice] = "You have updated book successfully."
        redirect_to book_path(params[:id])
      else
        render :edit
      end
   end


  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end



  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end