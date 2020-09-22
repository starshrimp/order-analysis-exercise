# Orders analysis exercise

In this exercise you will learn:

* [ ] How to read data from CSV files
* [ ] How to structure classes to store input data
* [ ] How to create associations between classes

## Tasks

This exercise has 3 Ruby files and 2 CSV files. The idea is to load the data from the CSV files and "glue" them together in Ruby classes.

The file `order_analysis.rb` is supposed to be executed. It already contains an example how to read data from one of the CSV files. Before you continue, execute this script **now** and have a look at the output. Also try to follow what happens in the existing code.


**Have you executed the script and analysed the output and the script?**

If yes, please continue... :wink:

From there we'd like to implement following things:

* [ ] Implement a `Customer` class (see `customer.rb`) where we "store"  data from `customers.csv`.
* [ ] Implement an `Order` class (see `order.rb`) where we "store" data from `orders.csv`.
* [ ] In `order_analysis.rb`, find and attach all loaded `Order` objects to the corresponding `Customer` objects. At the end each `Customer` object should have a list of `Orders`.
* [ ] Create a report that prints all customers and their orders in a fancy way (see example below).
* [ ] Make a report that list the customers ranked by their expenses (see example below).

## Need Guidance?

If you feel lost and require some sort of _"Guidance"_, there's a document that helps you go through the exercise step by step. Use it on your own responsibility.

[To the Guidance Document](GUIDANCE.md)

## Possible Outputs

Following are examples of how the described outputs could look like. Feel free to "design" them as you like.

### Report of customers with order details

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

Customer 3: Milo Jehle (Cape Town)
 - T-Shirt €48.95
 - Boxers €50.10
 - Swimwear €54.80
 - Bikini €40.35
 - Sarong €26.16
 - Fleece €20.31
Total: €240.67
# ...
```

### Report of Top-Customers

```
$ ruby order_analysis.rb top
Customer 6: Susan Mckenna (Lagos) (€555.61)
Customer 8: Ira Whitsett (Tokyo) (€481.81)
Customer 18: Julienne Charleston (Buenos Aires) (€432.19)
Customer 19: Edison Calixte (London) (€386.27)
Customer 20: Jenine Goldner (Zurich) (€381.72)
Customer 12: Georgette Lemasters (Berlin) (€363.59)
Customer 7: Catarina Keating (Madrid) (€352.9)
Customer 9: Kieth Acker (Amsterdam) (€335.72)
Customer 17: Dayna Esteves (Kabul) (€319.3)
Customer 14: Vashti Fraizer (Singapore) (€241.6)
Customer 3: Milo Jehle (Cape Town) (€240.67)
Customer 15: Izetta Agostini (Stockholm) (€229.88)
Customer 5: Darrick Flakes (Cairo) (€177.68)
Customer 2: Steven Miller (Bejing) (€173.97)
Customer 13: Shae Gildersleeve (Mumbai) (€165.36)
Customer 10: Lula Crutchfield (São Paolo) (€147.23)
Customer 1: Peter Parker (Paris) (€136.99)
Customer 16: Jonie Natividad (Helsinki) (€106.37)
Customer 4: Daron Treadaway (Los Angeles) (€79.79)
Customer 11: Syble Gehringer (Sydney) (€42.42)
Customer 21: Luanne Duchene (Jakarta) (€0)
Customer 22: Jeannine Cutting (Nairobi) (€0)
```
