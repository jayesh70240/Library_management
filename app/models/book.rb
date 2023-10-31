class Book < ApplicationRecord
    has_many :book_issues
    validates :title, presence: true, uniqueness: true
    validates :author, presence: true
    validates :checked_out, inclusion: { in: [true, false] }
end
