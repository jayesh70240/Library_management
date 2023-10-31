class BookIssue < ApplicationRecord
    belongs_to :book
    validates :patron_name,presence: true
        
    def return?
     
      return false unless book
      self.returned = true
      self.save!
          
      # Update the book's availability status
      book.update!(checked_out: false)
      # book.book_issues.last.update!(
      #   issued_date: nil,
      #   due_date: nil
      # )
      
      true
    end
    
end
