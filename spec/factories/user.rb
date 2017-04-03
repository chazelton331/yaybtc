FactoryGirl.define do
  factory :user do
    email            { "human-#{Time.now.to_f}-#{rand(1000)}@example.com" }
    password         "password"
  end
end
