class Customer
  @@all = []
  attr_reader :id, :first_name, :last_name, :location, :orders, :money_spent, :amount_of_orders
  def initialize(id, first_name, last_name, location)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @location = location
    @orders = []
    @@all.push(self)
    @money_spent = 0
  end
  def assign_order_to_customer(order)
    if order.customer == @id
      @orders.push(order)
    end
  end
  def self.all
    @@all
  end
  def output
    if orders.length != 0
      puts "Customer #{@id}: #{@first_name} #{@last_name} (#{@location})"
      puts "Orders for Customer #{@id}:" 
      orders.each do |order|
        order.output
      end
      cleaned_prices = orders.map do  |order|
        order.cleaned_price
      end
      @money_spent = cleaned_prices.sum
      puts "Total number of orders: #{orders.length}"
      puts "Total amount spent: €#{@money_spent} \n\n"
    else
      puts "Customer #{@id} (#{@first_name} #{@last_name} (#{@location})) has not placed any orders yet.\n\n"
    end
  end
end
