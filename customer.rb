class Customer
  @@all = []
  attr_accessor :id, :first_name, :last_name, :location, :orders, :money_spent, :amount_of_orders
  def initialize(id, first_name, last_name, location)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @location = location
    @orders = []
    @items = [] 
    @prices = []
    @money_spent
    @@all.push(self)
    @amount_of_orders
  end
  def order_to_customer(order)
    if order.customer == @id
      @orders.push(order)
    end
  end
  def self.all
    @@all
  end
 
  def output
    puts "Customer #{@id}: : #{@first_name} #{@last_name} (#{@location})"
    puts "Orders for Customer #{@id}:"
    @money_spent = 0
    @amount_of_orders = 0
    orders.each do |order|
      @items.push(order.item)
      @prices.push(order.price)
     
      @money_spent += order.price.to_i
      @amount_of_orders += 1
      order.output
      
    end
    puts "Total number of orders: \n #{@amount_of_orders}"
    puts "Total amount spent: \n €#{@money_spent} \n\n"

  end
end
  # See README.md
