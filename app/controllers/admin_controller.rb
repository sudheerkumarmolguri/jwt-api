class AdminController < ApplicationController
    before_action :authorize_user

    def show
     render json: { message: "Admin Dashboard", user: @current_user }
    end
 
   private
 
   def authorize_user
     unless @current_user.role == "admin"
     render json: { message: "Admin Dashboard", user: @current_user }
 
     end
   end
  end
  