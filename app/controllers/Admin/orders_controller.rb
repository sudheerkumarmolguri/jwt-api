# app/controllers/admin/orders_controller.rb
class Admin::OrdersController < ApplicationController
    before_action :authorize_request
    before_action :check_admin
  
    def index
      orders = Order.includes(:user).order(created_at: :desc)
      render json: orders
    end
   
    def update
      order = Order.find(params[:id])
      
      OrderApprovalJob.perform_now(order.id)

      if params[:order][:status] == "approved"
        OrderApprovalJob.perform_later(order.id)
      elsif params[:order][:status] == "rejected"
        OrderRejectionJob.perform_later(order.id)
      end
      render json: order, status: :accepted

    end

    def approve
      order = Order.find(params[:id])
      
    
      
      render json: { message: "Order approved", order: order }
    end
  
    def reject
      order = Order.find(params[:id])
      order.update(status: "rejected")
      render json: { message: "Order rejected", order: order }
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
  
    def check_admin
      return render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user.role == "admin"
    end

    def order_params
      params.require(:order).permit(:status)
    end

  end
  