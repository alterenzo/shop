FactoryGirl.define do
  factory :cart_element do
    quantity 1
    product
    cart
  end
end
