FactoryBot.define do
  factory :collaborator do
    sequence(:first_name) {|n| "first_name#{n}"}
    sequence(:last_name) {|n| "last_name#{n}"}
    sex :male
    salary 1000
    departments { [FactoryBot.create(:department)] }
  end
end