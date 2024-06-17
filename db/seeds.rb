# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'csv'

Product.destroy_all
Category.destroy_all

csv_file = Rails.root.join('db/products.csv')

if File.exist?(csv_file)
  csv_data = File.read(csv_file)
  products = CSV.parse(csv_data, headers: true)

  products.each do |product|
    category = Category.find_or_create_by(name: product['category'])
    Product.create(
      title: product['name'],
      price: product['price'],
      stock_quantity: product['stock_quantity'],
      category: category
    )
  end
else
  puts "CSV file not found"
end


