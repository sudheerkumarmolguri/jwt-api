class OrderRejectionJob < ApplicationJob
  queue_as :default

  def perform(*args)
   puts "Order creation testing..."
  end
end
