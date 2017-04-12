set :stage,     :production
set :rails_env, :production
set :branch,    "master"

server "btc.hazelton.info", user: "deploy", roles: %w{ app }
