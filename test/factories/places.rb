FactoryGirl.define do
  factory :place do
    name 'ABC Sandwiches'
    address '123 Sandwiches Ave'
    description 'Delicious sandwiches!'
    latitude(42.3631519)
    longitude(-71.056098)
    association :user
  end
end