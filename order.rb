# See README.md
class Order
  @@prices = []
  attr_accessor :customer, :item, :price; :orders; :items; :prices
  def initialize(customer, item, price)
    @customer = customer
    @item = item
    @price = price
    # @@items = [] 
    # @@prices
  end
  def output
    puts"#{@item} €#{@price}"
  end

end