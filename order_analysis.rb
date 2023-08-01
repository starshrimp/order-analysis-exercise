require_relative './order.rb'
require_relative './customer.rb'

class OrderAnalysis
  CSV_DELIMITER = ";"
  def initialize
    @customers = []

 
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
  # p @customers
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

  # def add_to_array(customer)
  #   @customers.push(@customer)
  # end

  def analyze_orders
    orders_csv = File.read("orders.csv")
    orders_lines = orders_csv.split("\n")

    orders_lines.each do |order_line|
      order = extract_order(order_line)
      @customers.each do |customer|
        customer.order_to_customer(order)
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
    @customers.each do |customer|
      customer.output
    end
  end
end

order_analysis = OrderAnalysis.new

# Analyze customers and populate @customers array
order_analysis.analyze
order_analysis.output
