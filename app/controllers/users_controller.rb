class UsersController < ApplicationController
    before_action :authorize_user

   def show
    render json: { message: "User Dashboard", user: @current_user }
   end

  private

  def authorize_user
    unless @current_user.role == "user"
    render json: { message: "User Dashboard", user: @current_user }

    end
  end
end
  