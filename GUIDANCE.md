# Order analysis exercise - Guidance

Welcome to the _"Guidance"_. This document will help you go through the exercise step by step. Please note that the suggested approach is **one of many**, it must not be considered as "the only one right solution".

This _"Guidance"_ contains a _"Pre-flight"_ chapter, where you learn how to use `File`-objects.

After the _"Pre-flight"_, the _"Guidance"_ is divided into multiple **milestones** to make the entire exercise more digestible.

## Pre-flight

This exercise uses Ruby's [`File` utility](https://ruby-doc.org/core/File.html), which allows us to read data from files.

### Try this in `irb`

In your terminal navigate to the folder where the files from this exercise are located in.

```shell
cd [path-to-the-order-analysis-exercise]
```

#### Reading data from a file

From here, enter `irb`, then do this:

```ruby
customers_file = File.read("customers.csv")
```

The input file is read as **one large string** which we store in a variable.

#### Splitting the file's content into rows

In order to work with the input data, we'd like to re-structure it into an Array. Why?

Having an Array, we can treat each **line** in a **loop**, which makes working with the data easier.

```ruby
customer_lines = customers_file.split("\n")
```

We tell ruby to `.split` the string at every "newline character" `\n`. After that we have an Array with String elements. Now go and print the 13th (or any other) element from that array:

```ruby
puts customer_lines[12]
# => 13;Shae;Gildersleeve;Mumbai
```

#### Splitting a file's row into cells

Next, we're going to split **each line** into "cells".

```ruby
customer_cells = customer_lines[12].split(";")
# => ["13", "Shae", "Gildersleeve", "Mumbai"]
```

Once again we're using `.split` to separate that String into multiple elements.
Finally, we can assign the individual elements to meaningful variables:

```ruby
customer_id = customer_cells[0]
first_name = customer_cells[1]
last_name = customer_cells[2]
location = customer_cells[3]
```

With this setup, we can start using the variables as usual. For example we could print customer info like this:

```ruby
puts "Customer #{customer_id}: #{first_name} #{last_name} (#{location})"
# => Customer 13: Shae Gildersleeve (Mumbai)
```

## Exercise

### Overview

This exercise consists of 3 Ruby files and 2 CSV files.

The Ruby files are

| Filename            | Comment                                     |
|---------------------|---------------------------------------------|
| `order_analysis.rb` | This class has to be modified and extended. |
| `customer.rb`       | This class has to be implemented entirely.  |
| `order.rb`          | This class has to be implemented entirely.  |

The CSV files are

| Filename       | Comment                                               |
|----------------|-------------------------------------------------------|
| `customer.csv` | Contains customer data.                               |
| `order.csv`    | Contains order data, with reference to customer data. |

### Running the code

We can execute `order_analysis.rb`. Please execute it and investigate the output.

```shell
ruby order_analysis.rb
```

Then have a look at `order_analysis.rb` and _try to understand_ what's going on in the existing code.

### Milestones

Let's dive into the actual exercise. We split it into several milestones, which should make it more digestible. :wink:

Please note that the following approach is just _one of many_. It is NOT the only way how to work with CSV-input data.

#### Milestone 1: The `Customer` class

The `Customer` class (or "model") will be defined in `customer.rb`.

1. Create a **constructor** that takes all customer data (`id`, `first_name`, etc.) as individual input arguments.
2. Assign each input argument to **instance variables** and define corresponding _getter methods_.
3. Then define a `print_info` method, that prints a nicely formatted customer information, for example `"Customer 13: Shae Gildersleeve (Mumbai)"`
4. Finally, use the `Customer` class in `OrderAnalysis`, and remove obsolete lines.

After these steps, the result should be the **same** as before:

```
$ ruby order_analysis.rb
Customer 1: Peter Parker (Paris)
Customer 2: Steven Miller (Bejing)
Customer 3: Milo Jehle (Cape Town)
# ...
Customer 20: Jenine Goldner (Zurich)
Customer 21: Luanne Duchene (Jakarta)
Customer 22: Jeannine Cutting (Nairobi)
```

### Milestone 2: The `Order` class

Next, we're going to implement similar things for the order-data.

1. A **constructor** that takes in order data as input arguments.
2. Again, assign each input argument to **instance variables** and define corresponding _getter methods_.
3. Define a `print_info` method, that prints a nicely formatted order information, for example `"Order for Customer 13: Swimming Shorts €39.58"`.
4. In `OrderAnalysis` add the required parts to load the data from `orders.csv`. You are most likely going to copy paste stuff from the existing code.
5. Make sure that the `Order` class is used.

After these steps. When you run the script, it should first print the customer information, then the order information, for example:

```
$ ruby order_analysis.rb
Customer 1: Peter Parker (Pari)
Customer 2: Steven Miller (Bejing)
Customer 3: Milo Jehle (Cape Town)
# ...
Order for Customer 18: Scarf €81.49
Order for Customer 16: Sandals €25.67
Order for Customer 15: Kilt €17.99
```

#### Milestone 3: Create associations between `Customer` and `Order`

This milestone consists of some changes in `Customer` class and rather drastic changes in `OrderAnalysis`. The class `Order` is primarily not getting any changes (but it can).

##### Changes in `Customer`

So far the two classes `Customer` and `Orders` are independent from each other, which we want to change. We'd like to be able to attach orders to the corresponding customers. In a nutshell, we want to achieve this:

```ruby
customer = Customer.new(...)
order = Order.new(...)

customer.attach_order(order)
customer.print_orders_info
# Output to be defined
```

That means that a `Customer` should have a container to store a list of `Order`'s. The method `attach_order` (feel free to pick another name) is used to add items to that list.

1. In `Customer`, make sure that a variable exists where we can store a list of `Order`'s.
2. Define a method `attach_order(argument)` that adds the input argument to the list of `Orders`'s.
3. Finally create a method `print_orders_info` that iterates through the list of `Order`'s and prints each objects' info (use `print_info` that we defined on `Order`).

##### Changes in `OrderAnalysis`

As announced, `OrderAnalysis` is going to receive many changes. Instead of reading and printing the customer and order information separately, we are going to try to read the data and connect the related data.

1. Prepare two variables to store a) a list of customers and b) a list of orders.
2. Remove the printing the customer/order information (`print_info`), instead add the created objects to the corresponding lists.
3. As a **new step** in the `analyze` method, iterate through the list of `Order`'s and find the corresponding `Customer`. Once found, add the `Order`-object to `Customer`-object (using `attach_order`). You can find the `Customer`-object using the first value from the `Order`-object.
4. Add another **new step** to the `analyze` method, where we loop through the list of `Customer`'s and call `print_orders_info`.

One **possible** summary could look like this.

```
$ ruby order_analysis.rb
Customer 1: Peter Parker (Paris)
 - Shawl €22.52
 - Jeans €71.52
 - Robe €42.95

Customer 2: Steven Miller (Bejing)
 - Tracksuit €94.91
 - Robe €79.06

# ...

Customer 21: Luanne Duchene (Jakarta)

Customer 22: Jeannine Cutting (Nairobi)

```

#### Milestone 4: Simple analysis

It would be nice to have an additional output that shows us the total amount (= sum) of a customer's purchase.

1. Implement a method on `Customer` that is responsible to calculate the sum of all orders.

The output could look like this:

```
$ ruby order_analysis.rb
Customer 1: Peter Parker (Paris)
 - Shawl €22.52
 - Jeans €71.52
 - Robe €42.95
Total: €136.99

Customer 2: Steven Miller (Bejing)
 - Tracksuit €94.91
 - Robe €79.06
Total: €173.97
# ...
```

#### Milestone 5: Advanced analysis (Bonus)

As an additional report, it would be interesting to list the customers sorted by their totals.

Example:

```
$ ruby order_analysis.rb top
Customer 6: Susan Mckenna (Lagos) (€555.61)
Customer 8: Ira Whitsett (Tokyo) (€481.81)
Customer 18: Julienne Charleston (Buenos Aires) (€432.19)
# ...
Customer 11: Syble Gehringer (Sydney) (€42.42)
Customer 21: Luanne Duchene (Jakarta) (€0)
Customer 22: Jeannine Cutting (Nairobi) (€0)
```
