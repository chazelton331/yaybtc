FactoryGirl.define do
  factory :user do
    email      { "human-#{Time.now.to_f}-#{rand(1000)}@example.com" }
    password   "password"
    wallet_id  "alkjfasldfkdsfkskf234u2jl42j3ri2rl"
  end
end
