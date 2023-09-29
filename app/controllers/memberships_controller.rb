class MembershipsController < ApplicationController
    before_action :authenticate_user!
    def new
        @membership = Membership.new
    end

    def show
        @membership = Membership.find(params[:id])
    end

    def create
        @membership = Membership.new(membership_params)
        if @membership.save
            flash[:success]= "Your Membership has activaed successfully."
            redirect_to @membership
        else
            render "new"
        end
    end

    def renew
        @membership = Membership.find(params[:id])
    end

    def expired?
        expiration_date < Date.today
    end
    
    def renewal_process
        @membership = Membership.find(params[:id])
        renewal_duration = params[:renewal_duration].to_i

        renewal_fee = @membership.renewal_fee(renewal_duration)

        payment_successful = true

        if payment_successful?
            new_expiration_date = @membership.expiration_date + renewal_duration.months
            @membership.update(expiration_date: new_expiration_date)
            flash[:success]= "Memebership renewed successfully."
            render "renewal_confirmation"
        else
            flash[:error] = "Renewal failed. Please try again or contact us."
            render "renew"
        end
    end

    # def search
    #     @query = params[:query]
      
    #     if @query.blank?
    #       @results = []
    #     else
    #       @results = Membership.where("name LIKE ? OR email LIKE ?", "%#{@query}%", "%#{@query}%")
    #     end
    #   end

    private
    def membership_params
        params.require(:membership).permit(:name, :email, :membership_type, :expiration_date)
    end
end
