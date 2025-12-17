class OrderApprovalJob < ApplicationJob
  queue_as :default

  def perform(order_id)
   # sadsdsadsad
    puts "Order#{order_id} and User"
    puts "Testing ...."
  end
end
