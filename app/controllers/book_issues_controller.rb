class BookIssuesController < ApplicationController
  before_action :authenticate_user!
  def new
    @book_issue = BookIssue.new
  end

  def create
    @book_issue = BookIssue.new(book_issue_params)
    if @book_issue.save
      
      flash[:success]= "Book issued Successfully."
    else
      flash[:error]= "Book issued failed, try again."
      render "new"
    end
  end

  def checked_out_items
    @checked_out_items = current_user.checked_out_items
  end

  def renew
    @book_issue = BookIssue.find(params[:id])

    if @book_issue.renew
      flash[:success] = "Item renewed successfully."
    else
      flash[:error] = "Renewal failed. Item may be on hold or renewal limit reached."
    end

    redirect_to checked_out_items_book_issues_path
  end

  def return
    @book_issue = BookIssue.find(params[:id])
  
    if @book_issue.return
      flash[:success] = "Item returned successfully."
    else
      flash[:error] = "Return failed. Please contact library staff."
    end
  
    redirect_to checked_out_items_book_issues_path
  end

  def create
    @book_issue = BookIssue.new(book_issue_params)
  
    if @book_issue.save
      
      Transaction.create(
        book: @book_issue.book,
        patron_name: @book_issue.patron_name,
        transaction_type: "issue",
        transaction_date: Time.zone.now
      )
      @book_issue.book.update(checked_out: true)
      flash[:success] = "Item issued successfully."
      redirect_to checked_out_items_book_issues_path
    else
      render "new"
    end
  end
  
  def return
    @book_issue = BookIssue.find(params[:id])
  
    if @book_issue.return
      Transaction.create(
        book: @book_issue.book,
        patron_name: @book_issue.patron_name,
        transaction_type: "return",
        transaction_date: Time.zone.now
      )
  
      flash[:success] = "Item returned successfully."
    else
      flash[:error] = "Return failed. Please contact library staff."
    end
  
    redirect_to checked_out_items_book_issues_path
  end

  private

  def book_issue_params
    params.require(:book_issue).permit(:patron_name, :book_id)
  end
end
