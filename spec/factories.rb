FactoryGirl.define do
  sequence :name do |n|
    "name_#{n}"
  end

  factory :recipe do
    name
  end

  factory :ingredient do
    recipe
    name
    amount 'A bit'
  end
end
