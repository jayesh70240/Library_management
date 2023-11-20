class BookIssuesController < ApplicationController
  before_action :check_librarian_or_admin_role

  def new
    @book_issue = BookIssue.new
  end

  def create
    book_issue = BookIssue.new(book_issue_params)
    if book_issue.save
      
      Transaction.create(
        book: book_issue.book,
        patron_name: book_issue.patron_name,
        transaction_type: "issue",
        transaction_date: Time.zone.now
      )
      book_issue.update(
        issued_date: Date.current,
        due_date: Date.current+7
        )
        book_issue.book.update(checked_out: true)
        
      flash[:success] = "Item issued successfully."
      redirect_to books_path
    else
      render "new"
    end
  end
  
  def return

    # book_issue = BookIssue.find(params[:id])
    book = Book.find(params[:id])  #finding book params from the database
    book_issue = book&.book_issues.last
    
    if book_issue.return?
      Transaction.create(
        book: book_issue.book,
        patron_name: book_issue.patron_name,
        transaction_type: "return",
        transaction_date: Time.zone.now
      )
      
      flash[:success] = "Item returned successfully."
    else
      flash[:error] = "Return failed. Please contact library staff."
    end
  
    redirect_to books_path
  end

  private

  def book_issue_params
    params.require(:book_issue).permit(:patron_name, :book_id)
  end
end
