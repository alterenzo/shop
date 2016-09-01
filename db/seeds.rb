# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

data = [{name: "Almond Toe Court Shoes, Patent Black", category: "Women’s Footwear", price: 99.0, stock: 5, discount_amount: 0.0},
{name: "Suede Shoes, Blue", category: "Women’s Footwear", price: 42.0, stock: 4, discount_amount: 0.0},
{name: "Leather Driver Saddle Loafers, Tan", category: "Men’s Footwear", price: 34.0, stock: 12, discount_amount: 0.0},
{name: "Flip Flops, Red", category: "Men’s Footwear", price: 19.0, stock: 6, discount_amount: 0.0},
{name: "Flip Flops, Blue", category: "Men’s Footwear", price: 19.0, stock: 0, discount_amount: 0.0},
{name: "Gold Button Cardigan, Black", category: "Women’s Casualwear", price: 167.0, stock: 6, discount_amount: 0.0},
{name: "Cotton Shorts, Medium Red", category: "Women’s Casualwear", price: 30.0, stock: 5, discount_amount: 0.0},
{name: "Fine Stripe Short Sleeve Shirt, Grey", category: "Men’s Casualwear", price: 49.99, stock: 9, discount_amount: 0.0},
{name: "Fine Stripe Short Sleeve Shirt, Green", category: "Men’s Casualwear", price: 49.99, discount_amount: 10.0, stock: 3},
{name: "Sharkskin Waistcoat, Charcoal", category: "Men’s Formalwear", price: 75.0, stock: 2, discount_amount: 0.0},
{name: "Lightweight Patch Pocket Blazer, Deer", category: "Men’s Formalwear", price: 175.5, stock: 1, discount_amount: 0.0},
{name: "Bird Print Dress, Black", category: "Women’s Formalwear", price: 270.0, stock: 10, discount_amount: 0.0},
{name: "Mid Twist Cut-Out Dress, Pink", category: "Women’s Formalwear", price: 540.0, stock: 5, discount_amount: 0.0}]


data.each do |x|
  cat = Category.where(name: x[:category]).first_or_create
  prod = Product.create(name: x[:name], price: x[:price], category_id: cat.id, stock: x[:stock], discount_amount: x[:discount_amount])
end

Product.find(9).discount_amount = 10.00
Voucher.create(code: "5OFF", discount_amount: 5.00)
Voucher.create(code: "10OFF", min_amount: 50.0, discount_amount: 10.00)
v = Voucher.new(code: "15OFF", min_amount: 75.0, discount_amount: 15.00)
v.categories << Category.find(1)
v.categories << Category.find(2)
v.save
