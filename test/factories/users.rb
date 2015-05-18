FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    password "something12345"
    password_confirmation "something12345"
  end
end