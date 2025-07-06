FactoryBot.define do
  factory :item do
    name { "MyString" }
    info { "MyText" }
    price { 1 }
    user { nil }
    category_id { 1 }
    sales_status_id { 1 }
    shipping_fee_status_id { 1 }
    prefecture_id { 1 }
    scheduled_delivery_id { 1 }
  end
end
