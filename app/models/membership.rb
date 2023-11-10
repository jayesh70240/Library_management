class Membership < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :membership_type, presence: true
    validates :expiration_date, presence: true

    def renew(duration_months)
        return false if duration_months <= 0
 
        new_expiration_date = expiration_date.to_date+ duration_months.months
        update(expiration_date: new_expiration_date)
        true
    end

    def expired?
        expiration_date.to_date < Date.today
    end
end
