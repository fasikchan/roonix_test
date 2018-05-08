FactoryBot.define do
  factory :department do
    sequence(:department_name) {|n| "department_name#{n}"}
  end
end