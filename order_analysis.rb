require_relative './order.rb'
require_relative './customer.rb'

class OrderAnalysis
  CSV_DELIMITER = ";"
  def initialize
    @customers = []
    @orders = []
 
  end
  def analyze
    analyze_customers
    analyze_orders
  end

  def analyze_customers
    customers_csv = File.read("customers.csv")
    customer_lines = customers_csv.split("\n")

    customer_lines.each do |customer_line|
      extract_customer(customer_line)

    end
    p @customers
  end

  def extract_customer(line)
    parts = line.split(CSV_DELIMITER)
    if parts.size != 4
      puts "[ERROR] Something's wrong with this customer line: #{line}!"
      return
    end

    customer = Customer.new(parts[0], parts[1], parts[2], parts[3])
    @customers.push(customer)

    puts "Customer #{customer.id}: #{customer.first_name} #{customer.last_name} (#{customer.location})"
  end

  # def add_to_array(customer)
  #   @customers.push(@customer)
  # end

  def analyze_orders
    orders_csv = File.read("orders.csv")
    orders_lines = orders_csv.split("\n")

    orders_lines.each do |order_line|
      extract_order(order_line)
    end
  end
  def extract_order(line)
    parts = line.split(CSV_DELIMITER)
    if parts.size != 3
      puts "[ERROR] Something's wrong with this order line: #{line}!"
      return
    end

    @order = Orders.new(parts[0], parts[1], parts[2])
    @orders.push(@order)

    puts "Order for Customer #{@order.customer}: #{@order.item} #{@order.price}"
  end
  def add_order(customer)
    @customers.push(customer)
    @customers.each(&:output_orders)
  
  end
  
end

order_analysis = OrderAnalysis.new

# Analyze customers and populate @customers array
order_analysis.analyze
order_analysis.add_order
