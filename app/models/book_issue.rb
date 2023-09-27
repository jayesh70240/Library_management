class BookIssue < ApplicationRecord
    belongs_to :book
    
    def renew
      return false if renewal_not_allowed?
  
      new_due_date = Time.zone.now + 2.weeks # Adjust the renewal period as needed
      self.due_date = new_due_date
      self.save
    end
    
    def return
        return false if returned?
    
        self.returned = true
        self.save
        
        # Update the book's availability status
        book.update(checked_out: false)
      end
end
