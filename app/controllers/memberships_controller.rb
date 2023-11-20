class MembershipsController < ApplicationController
    def index
        @memberships = Membership.all
    end

    def new
        @membership = Membership.new
    end

    def show
        @membership = Membership.find(params[:id])
    end

    def create
        @membership = Membership.new(membership_params)
        if @membership.save
            flash[:success]= "Your Membership has activated successfully."
            redirect_to @membership
        else
            render "new"
        end
    end

    def renew
        @membership = Membership.find(params[:id])
    end
    
    def renewal_process
        @membership = Membership.find(params[:id])
        duration_months = params[:renewal_duration].to_i

        if @membership.renew(duration_months)
            flash[:success]= "Memebership renewed Successfully."
            render :renewal_confirmation
        else
            flash[:error] = "Renewal failed. Please try again or contact us."
            render :renew
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
        params.require(:membership).permit(:name, :email, :membership_type, :expiration_date, :user_id)
    end
end
