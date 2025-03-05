# Vending machine product list
products = {
  1 => { name: "Chips", price: 50 },
  2 => { name: "Soda", price: 30 },
  3 => { name: "Chocolate", price: 40 }
}

puts "Welcome to the Vending Machine!"

loop do
  # Display product list
  puts "\nAvailable Products:"
  products.each do |key, item|
    puts "#{key}. #{item[:name]} - ₹#{item[:price]}"
  end
  puts "Enter 'Cancel' to exit at any time."

  # Product selection
  selected_product = nil
  loop do
    print "\nSelect a product (1-3): "
    input = gets.chomp.downcase
    break if input == "cancel"

    selected_product = products[input.to_i]
    if selected_product
      break
    else
      puts "Invalid selection. Please enter 1, 2, or 3."
    end
  end

  # Exit if user cancels
  break unless selected_product

  # Quantity selection
  quantity = nil
  loop do
    print "Enter quantity: "
    input = gets.chomp.downcase
    break if input == "cancel"

    quantity = input.to_i
    if quantity > 0
      break
    else
      puts "Invalid quantity. Please enter a valid number."
    end
  end

  # Exit if user cancels
  break unless quantity

  # Calculate total price
  total_price = selected_product[:price] * quantity
  puts "Total cost: ₹#{total_price}"

  # Money insertion
  amount_inserted = 0
  while amount_inserted < total_price
    print "Insert money (₹#{total_price - amount_inserted} needed): "
    input = gets.chomp.downcase
    break if input == "cancel"
    
    money = input.to_i
    if money > 0
      amount_inserted += money
    else
      puts "Invalid amount. Please insert valid money."
    end
  end

  # Exit if user cancels
  break unless amount_inserted >= total_price

  # Calculate change if extra money is inserted
  change = amount_inserted - total_price
  puts "\nTransaction Summary:"
  puts "Product: #{selected_product[:name]}"
  puts "Quantity: #{quantity}"
  puts "Total Paid: ₹#{amount_inserted}"
  puts "Change Returned: ₹#{change}" if change > 0

  # Ask for another transaction
  print "\nDo you want to buy another product? (yes/no): "
  continue = gets.chomp.downcase
  break unless continue == "yes"
end

puts "Thank you for using the Vending Machine!"


#-----------------------------------------------------------------------



class Library
  def initialize
    @library = {
      "978-0143127741" => { title: "The Alchemist", author: "Paulo Coelho", copies: 5 },
      "978-0062315007" => { title: "Sapiens", author: "Yuval Noah Harari", copies: 3 },
      "978-0451524935" => { title: "1984", author: "George Orwell", copies: 4 }
    }
  end

  def add_book
    print "Enter the new book's title: "
    title = gets.chomp
    print "Enter the author's name: "
    author = gets.chomp
    print "Enter the ISBN: "
    isbn = gets.chomp
    print "Enter the number of copies: "
    copies = gets.chomp.to_i
    
    if @library.key?(isbn)
      puts "Book with this ISBN already exists."
    else
      @library[isbn] = { title: title, author: author, copies: copies }
      puts "New book added!"
    end
  end

  def update_copies
    print "Enter the ISBN to update copies: "
    isbn = gets.chomp
    if @library.key?(isbn)
      print "Enter the new number of copies: "
      @library[isbn][:copies] = gets.chomp.to_i
      puts "Book copies updated!"
    else
      puts "Book not found."
    end
  end

  def remove_book
    print "Enter the ISBN to remove: "
    isbn = gets.chomp
    if @library.delete(isbn)
      puts "Book removed successfully!"
    else
      puts "Book not found."
    end
  end

  def search_book
    print "Enter the ISBN to search: "
    isbn = gets.chomp
    if @library.key?(isbn)
      book = @library[isbn]
      puts "Book Details:"
      puts "Title: #{book[:title]}"
      puts "Author: #{book[:author]}"
      puts "Copies Available: #{book[:copies]}"
    else
      puts "Book not found."
    end
  end

  def list_books
    puts "Library Catalog:"
    puts "ISBN                Title                 Author                 Copies"
    puts "-----------------------------------------------------------------"
    @library.each do |isbn, book|
      puts "#{isbn.ljust(20)} #{book[:title].ljust(20)} #{book[:author].ljust(20)} #{book[:copies]}"
    end
  end

  def menu
    loop do
      puts "\nLibrary System Menu"
      puts "1. Add Book"
      puts "2. Update Copies"
      puts "3. Remove Book"
      puts "4. Search Book"
      puts "5. List All Books"
      puts "6. Exit"
      print "Choose an option: "
      choice = gets.chomp.to_i

      case choice
      when 1 then add_book
      when 2 then update_copies
      when 3 then remove_book
      when 4 then search_book
      when 5 then list_books
      when 6 then break
      else puts "Invalid choice. Please try again."
      end
    end
  end
end

# Run the library program
library = Library.new
library.menu


#-----------------------------------------------------------------------------


class Product
  attr_accessor :name, :price, :description

  def initialize(name, price, description)
    @name = name
    @price = price
    @description = description
  end

  def discount
    @price * 0.90 # Default 10% discount for all products
  end
end

class Book < Product
  attr_accessor :author, :isbn

  def initialize(name, price, description, author, isbn)
    super(name, price, description)
    @author = author
    @isbn = isbn
  end

  def discount
    @price * 0.85 # Books have a 15% discount
  end
end

class Clothing < Product
  attr_accessor :size, :color

  def initialize(name, price, description, size, color)
    super(name, price, description)
    @size = size
    @color = color
  end

  def discount
    @price * 0.80 # Clothing items have a 20% discount
  end
end

# Creating instances of different product types
book = Book.new("The Alchemist", 20.00, "A novel by Paulo Coelho", "Paulo Coelho", "978-0061122415")
clothing = Clothing.new("T-Shirt", 15.00, "Cotton round-neck t-shirt", "M", "Blue")

# Displaying information and discounted prices
puts "Book: #{book.name}, Author: #{book.author}, Discounted Price: $#{'%.2f' % book.discount}"
puts "Clothing: #{clothing.name}, Size: #{clothing.size}, Color: #{clothing.color}, Discounted Price: $#{'%.2f' % clothing.discount}"
