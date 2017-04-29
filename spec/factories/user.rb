FactoryGirl.define do
  factory :user do
    name { "human-#{Time.now.to_f}-#{rand(1000)}" }
  end
end
