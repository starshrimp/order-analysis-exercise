# See README.md
class Order
  attr_accessor :customer, :item, :price
  def initialize(customer, item, price)
    @customer = customer
    @item = item
    @price = price
  end
  def output
    puts"  •   #{@item} #{@price}"
  end
  def cleaned_price
    cleaned_string = @price.gsub("€", "")
    return cleaned_string.to_i
  end
  def self.all_items
    @@all_items
  end
end
