# See README.md
class Order
  attr_accessor :customer, :item, :price
  def initialize(customer, item, price)
    @customer = customer
    @item = item
    @price = price
  end
  def output
    puts "Order for Customer #{@customer}: #{@item} #{@price}"
  end
end