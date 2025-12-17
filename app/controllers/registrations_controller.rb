class RegistrationsController < ApplicationController
  wrap_parameters false

    def create
      user = User.new(user_params)
      #raise user.inspect
      if user.save
        token = JsonWebToken.encode(user_id: user.id)
        render json: { token: token, user: user }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity

      end
    end
  
    private
  
    def user_params
      params.permit(:email, :password)
    end
end
  