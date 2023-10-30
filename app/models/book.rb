class Book < ApplicationRecord
    has_one :book_issue
    validates :title, presence: true, uniqueness: true
    validates :author, presence: true
    validates :checked_out, inclusion: { in: [true, false] }
end
