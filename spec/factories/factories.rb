# FactoryGirl.define do
#   factory :product do
#     name { generate :product_name }
#     category_name
#     price { (rand(100.0)*100).round / 100.0 }
#   end
#
#   factory :category do
#     name { generate :category_name }
#   end
#
#   sequence :product_name do |n|
#     "Product#{n}"
#   end
#
#   sequence :category_name do |n|
#     "Category#{n}"
#   end
#
#
# end
