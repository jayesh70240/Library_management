class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:user, :librarian, :admin]

  # add default role when newly user created!
  before_save do
    self.role = :user unless ['librarian', 'admin'].include?(self.role)
  end
end
