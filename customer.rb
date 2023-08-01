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
  def output_orders
    puts "Orders for Customer #{@id}:"
    p @orders
    # @items.each_with_index do |item, index|
    #   p @orders
    # end
  end
  def output
    p "Customer #{@id}: : #{@first_name} #{@last_name} (#{@location})"
  end
end
  # See README.md
