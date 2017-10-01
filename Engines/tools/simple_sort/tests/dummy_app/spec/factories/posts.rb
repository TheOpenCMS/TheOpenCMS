FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Post #{n}" }
    body { Forgery(:lorem_ipsum).words(5) }
  end
end
