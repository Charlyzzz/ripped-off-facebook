FactoryGirl.define do
  factory :user do |f|
    f.name 'John'
    f.username 'John 1960'
    f.birth_date Date.new(2000, 1, 1)
  end
end
