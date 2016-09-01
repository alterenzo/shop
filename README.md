# Shop

A Rails app that simulates a simple shop page, with a Cart on which is possible to add products, and apply voucher codes.

### Usage

#### To run the server on your local machine:

 - Download or clone the repo
 - Run ```$ bundle install```
 - Install PostgreSQL ```brew install postgresql```
 - Create the database with ```$ rake db:create```
 - Migrate ```$ rake db:migrate```
 - And seed the db ```$ rake db:seed```
 - Run ```$ rails s``` to start the server

 Once the server is running, visit http://localhost:3000 in your browser

#### WebApp Usage:

All the products are created when the database is seeded.
You can add a product to the cart clicking on the "Add to cart" button.
You can remove an added item clicking on the "Remove" button.

Every time an item is added, the total price is updated.

##### Vouchers:

There are three vouchers that can be used:

- A £ 5.00 discount, that can be applied using the code "5OFF"
- A £ 10.00 discount, that can be applied using the code "10OFF", and only works if the total amount is at least £ 50.00
- A £ 15.00 discount, that can be applied using the code "15OFF",
and only works if the total amount is at least £ 75.00 and one footwear item is in the cart


### Models

##### Product:

The "main" model that stores the basic information about products, like price, and product name.
Every product belongs to a category.

##### Category:

This model only stores the name of the category, and is associated with products and vouchers.

##### Cart:

This model stores a collection of Cart Elements, and takes care of computing the following:
- total_price (price of all the items, before discounts).
- total_voucher_amount (total amount of discounts)
- final_price (total price after discounts)

It has a many to many relationship with Vouchers, through the AppliedVoucher model

##### CartElement:

This model represent one single "row" of the cart.
It computes its own price, given by the unit price multiplied by quantity.

It also checks for stock availability before creating. (if an item has a stock of 2, it won't let it add more than twice).

##### Voucher:

This model stores the information and validity criteria for every Voucher.
It has a many to many relationship with carts, though AppliedVoucher, and a many to many relationship with Category (so that a voucher can have category requirements).

##### AppliedVoucher:

This is the model that stores the vouchers applied on each cart, and it also takes care of checking the validity criteria, before applying it, with the following methods:

- verify_min_amount: it just adds an error if the cart total price has not reached the minimum amount required by the voucher

- verify_product_categories: it skips the check if the voucher is not there (error handled by another validation), or if the required categories on the voucher are empty (meaning that there are no required categories). Then it checks if any of the products in the cart belongs to one of the required categories.

The validity of each voucher is also checked every time a product is removed from the cart, and if it is not valid, the voucher is removed

(Even though it was not explicitly required in the spec, I have assumed that a same coupon cannot be applied more than once, therefore I have added uniqueness validation on the coupons applied to one cart )

### Test

RSpec is the testing framework used, with Capybara used to run the integration test.

Run tests using:
```
$ rspec
```


### Reasoning and Conclusion:

Although the requirement was fairly simple, I've tried to model it making it easy to expand.
Initially I though of relying on the Cart model to take care of the vouchers, but creating a different class allows to easily add new ones, and also create new kind of criteria (for example an expiry date adding a new column and a validator).
