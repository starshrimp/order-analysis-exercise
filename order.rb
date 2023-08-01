# See README.md
class Orders
  attr_accessor :customer, :item, :price
  def initialize(customer, item, price)
    @customer = customer
    @item = item
    @price = price
  end
end