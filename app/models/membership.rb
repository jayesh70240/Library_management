class Membership < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :membership_type, presence: true
    validates :expiration_date, presence: true

    def renew(duration_months)
        return false if duration_months <= 0

        new_expiration_date = expiration_date + duration_months.months
        update(expiration_date: new_expiration_date)
    end

    def renewal_fee(renewal_duration)
        base_fee = 50
        discount_rate = 0.1

        renewal_fee = base_fee * renewal_duration

        renewal_fee -= (renewal_fee * discount_rate) if renewal_duration > 1
    
        return renewal_fee
      end
end
