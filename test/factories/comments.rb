FactoryGirl.define do
  factory :comment do
    message "some message"
    association :user
    association :place
  end
end