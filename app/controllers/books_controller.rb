class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
    @books = Book.all
  end
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success]= "Book Uploaded Successfully."
      redirect_to books_path
    else
      flash[:error]= "Upload failed."
      render "new"
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :author, :checked_out)
  end
end
