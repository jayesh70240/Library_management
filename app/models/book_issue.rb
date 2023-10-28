class BookIssue < ApplicationRecord
    belongs_to :book
        
    def return
      return unless book
      self.returned = true
      self.save
          
      # Update the book's availability status
      book.update(checked_out: false)

    end
    
    validates :patron_name,presence: true
end
