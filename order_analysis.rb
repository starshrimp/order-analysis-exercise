require_relative './order.rb'
require_relative './customer.rb'

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
    customers_csv = File.read("customers.csv")
    customer_lines = customers_csv.split("\n")

    customer_lines.each do |customer_line|
      extract_customer(customer_line)

    end
  end

  def extract_customer(line)
    parts = line.split(CSV_DELIMITER)
    if parts.size != 4
      puts "[ERROR] Something's wrong with this customer line: #{line}!"
      return
    end

    customer = Customer.new(parts[0], parts[1], parts[2], parts[3])
    @customers.push(customer)

  end

  def parse_order_csv
    orders_csv = File.read("orders.csv")
    orders_lines = orders_csv.split("\n")

    orders_lines.each do |order_line|
      order = extract_order(order_line)
      @customers.each do |customer|
        customer.assign_order_to_customer(order)
      end
    end
  end
  def extract_order(line)
    parts = line.split(CSV_DELIMITER)
    if parts.size != 3
      puts "[ERROR] Something's wrong with this order line: #{line}!"
      return
    end
    order = Order.new(parts[0], parts[1], parts[2])
  end
  def output
    @customers.each(&:output)
  end
  def top_orders
    sort_by_money_spent
    puts "Here's a list of the top customers:"
    index = 1
    sort_by_money_spent.each do |customer|
      puts "Nr. #{index}: Customer #{customer.id}: #{customer.first_name} #{customer.last_name} (#{customer.location}): €#{customer.money_spent} in #{customer.orders.length} orders."
      index += 1
    end
    puts "\n\n"
  end
  def sort_by_money_spent
    Customer.all.sort_by { |customer| -customer.money_spent }
  end
  def only_unique_items
    # p Order.all_items
    @unique_orders = Order.all_items.uniq
    return @unique_orders
  end
  def count_items
     @counted_items = {}
     @unique_orders.each do |item|
      item_counter = Order.all_items.count(item)
      @counted_items[item] = item_counter
    end
    sort_items
  end
  def sort_items
    @sorted_items = @counted_items.sort_by(&:last).reverse
    analyze_items
  end
  def analyze_items
    puts "Here's a list of our topsellers:"
    @sorted_items = @sorted_items.group_by{|k,v| v}
    @sorted_items.each do |key, value|
      items = value.map { |inner_array| inner_array[0] }
      items = items.join(', ')
      puts "The following items were bought #{key} times : #{items}"
    end
  end

end

order_analysis = OrderAnalysis.new

order_analysis.parse
order_analysis.output
order_analysis.top_orders
order_analysis.only_unique_items
order_analysis.count_items

