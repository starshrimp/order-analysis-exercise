require_relative './order.rb'
require_relative './customer.rb'
require_relative './item.rb'
require 'csv'

class OrderAnalysis
  CSV_DELIMITER = ","   
  def initialize
    @customers = []
  end
  def parse
    parse_customer_csv
    parse_order_csv
  end
  def parse_customer_csv
    CSV.foreach('customers.csv') do |row|
      if row.size != 4 
        puts "[ERROR] Something's wrong with this order line: #{row}!"
        return
      end
      id = row[0]
      first_name = row[1]
      last_name = row[2]
      location = row[3]
      customer = Customer.new(id, first_name, last_name, location)
      @customers.push(customer)
    end
  end
  def parse_order_csv
    CSV.foreach('orders.csv') do |row|
      if row.size != 3 
        puts "[ERROR] Something's wrong with this order line: #{row}!"
        return
      end
      customer = row[0]
      item = row[1]
      price = row[2]
      order = Order.new(customer, item, price)
      @customers.each do |customer|
        customer.assign_order_to_customer(order)
      end
      Item.increment_item_counter(order.item)
    end
  end
  def output
    @customers.each(&:output)
  end
  def analyze_top_orders
    sort_by_money_spent
    puts "Here's a list of the top customers:"
    index = 1
    sort_by_money_spent.each do |customer|
      if customer.orders.length != 0
        puts "Nr. #{index}: Customer #{customer.id}: #{customer.first_name} #{customer.last_name} (#{customer.location}): €#{customer.money_spent} in #{customer.orders.length} orders."
        index += 1
      end
    end
    puts "\n\n"
  end
  def sort_by_money_spent
    Customer.all.sort_by { |customer| -customer.money_spent }
  end
  def sort_by_times_bought
    Item.item_counters.sort_by { |item, count| -count }
  end
  def group_by_times_bought
    @sorted_items = @sorted_items.group_by { |item, count| count }
    items_sold_x_times = {}
    @sorted_items.each do |count, items_array|
      transformed_items = items_array.map do |item_count_pair|
        item_count_pair.first
      end
      items_sold_x_times[count] = transformed_items
    end
    return items_sold_x_times
  end
  def analyze_top_items
    puts "Here's a list of our topsellers:"
    @sorted_items = sort_by_times_bought
    @grouped_items = group_by_times_bought
    @grouped_items.each do |count, item_name|
      items = item_name.join(', ')
      puts "The following items were bought #{count} times: #{items}."
    end
  end
end

order_analysis = OrderAnalysis.new
order_analysis.parse
order_analysis.output
order_analysis.analyze_top_orders
order_analysis.analyze_top_items

