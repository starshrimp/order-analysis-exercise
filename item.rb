class Item
  attr_accessor :item_name, :price
  @@item_counters = Hash.new(0)
  def initialize(item_name, price)
    @item_name = item_name
    @price = price
    @@item_counters[item_name] ||= 0
  end 
  def self.item_counters
    @@item_counters
  end
  def self.increment_item_counter(item_name)
    @@item_counters[item_name] += 1
  end
  def item_counters
    @@item_counters
  end
end
