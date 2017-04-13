set :stage,     :production
set :rails_env, :production
set :branch,    "master"

server "67.205.150.41", user: "deploy", roles: %w{ app }
