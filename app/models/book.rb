class Book < ApplicationRecord
    validates :title, presence: true
    validates :author, presence: true
    validates :checked_out, inclusion: { in: [true, false] }
end
