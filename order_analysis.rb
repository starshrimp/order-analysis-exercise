require_relative './order.rb'
require_relative './customer.rb'
require_relative './item.rb'
require 'csv'

class OrderAnalysis
  CSV_DELIMITER = ";"   
  def initialize
    @customers = []
  end
  def parse
    parse_customer_csv
    parse_order_csv
  end
  def parse_customer_csv
    path = 'customers.csv'
    customer_lines = []
    customer_lines = File.read(path).split("\n")
    customer_lines.each do |customer_line|
      extract_customer(customer_line)
    end
  end
  def extract_customer(line)
    column = CSV.parse_line(line, col_sep: ';')
    column1 = column[0] 
    column2 = column[1] 
    column3 = column[2]
    column4 = column[3]
    if column.size != 4
    puts "[ERROR] Something's wrong with this customer line: #{line}!"
    return
    end
    customer = Customer.new(column[0], column[1], column[2], column[3])
    @customers.push(customer)
  end

  def parse_order_csv
    orders_lines = File.read("orders.csv").split("\n")
    orders_lines.each do |order_line|
      order = extract_order(order_line)
      @customers.each do |customer|
        customer.assign_order_to_customer(order)
      end
      item = Item.new(order.item, order.cleaned_price)
    end
  
  end
  def extract_order(line)
    parts = line.split(CSV_DELIMITER)
    if parts.size != 3
      puts "[ERROR] Something's wrong with this order line: #{line}!"
      return
    end
    order = Order.new(parts[0], parts[1], parts[2])
    Item.increment_item_counter(order.item)
    return order
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

