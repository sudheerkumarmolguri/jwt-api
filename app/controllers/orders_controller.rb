class OrdersController < ApplicationController
    before_action :authorize_request   # JWT authentication

    def index
        orders = @current_user.orders
        render json: orders
    end

    def create
      order = @current_user.orders.new(order_params)
      order.status = "pending"
    
      if order.save
        render json: order, status: :created
      else
        render json: { errors: order.errors.full_messages },
               status: :unprocessable_content
      end
    end
    
  
    def destroy
      order = @current_user.orders.find_by(id: params[:id])
      if order
        order.destroy
        render json: { message: "Order deleted successfully" }, status: :ok
      else
        render json: { error: "Order not found or not yours" }, status: :not_found
      end
    end
    
    
    private
  
    def order_params
      params.permit(:product_name, :quantity)
    end
  end
  