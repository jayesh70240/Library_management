class BookIssue < ApplicationRecord
    belongs_to :book
    validates :patron_name,presence: true
        
    def return?
      byebug
      return false unless book
      self.returned = true
      self.save!
          
      # Update the book's availability status
      book.update!(checked_out: false)
      book.book_issue.update!(
        issued_date: nil,
        due_date: nil
      )
      byebug
      true
    end
    
end
