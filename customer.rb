class Customer
  attr_accessor :id, :first_name, :last_name, :location, :orders
  def initialize(id, first_name, last_name, location)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @location = location
    @orders = []
   
  end
  def order_to_customer(order)
    if order.customer == @id
      @orders.push(order)
    end
  end
 
  def output
    puts "Customer #{@id}: : #{@first_name} #{@last_name} (#{@location})"
    orders.each do |order|
      order.output
    end
  end
end
  # See README.md
