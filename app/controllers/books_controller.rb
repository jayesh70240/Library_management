class BooksController < ApplicationController
  def index
    @book = Book.all
  end
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success]= "Book Uploaded Successfully."
    else
      flash[:error]= "Upload failed."
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :author, :checked_out)
  end
end
