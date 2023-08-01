class Customer
  attr_accessor :id, :first_name, :last_name, :location, :items, :prices
  def initialize(id, first_name, last_name, location)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @location = location
    @items = []
    @prices = []
  end
  def order_to_customer(order)
    if order.customer == @id
      @items.push(order.item)
      @prices.push(order.price)
    end
  end
  def output_orders
    puts "Orders for Customer #{@id}:"
    @items.each_with_index do |item, index|
      puts "#{index + 1}. #{item} - #{@prices[index]}"
    end
  end
  
    
end
  # See README.md
