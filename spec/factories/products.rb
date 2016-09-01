FactoryGirl.define do
  factory :product do
    name { generate :product_name }
    price { (rand(100.0)*100).round / 100.0 }
    stock 2
    category
    discount_amount 0.0
  end

  sequence :product_name do |n|
    "Product#{n}"
  end
end
