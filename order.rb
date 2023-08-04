# See README.md
class Order
  @@all_items = []
  @@unique_items = []
  attr_accessor :customer, :item, :price; :orders; :items; :prices
  def initialize(customer, item, price)
    @customer = customer
    @item = item
    @price = price
    @@all_items.push(@item)
  end
  def output
    puts"#{@item} #{@price}"
  end
  def price
    cleaned_string = @price.gsub("€", "")
    return cleaned_string
  end
  def self.all_items
    @@all_items
  end
  def uniq
    @@unique_items = @@all_items.uniq
  end
end
