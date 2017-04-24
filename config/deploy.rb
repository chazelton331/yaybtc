# config valid only for current version of Capistrano
lock '3.4.0'

set :application,   'btc.hazelton.info'

set :rvm_type,       :user
set :assets_roles,   [ :app ]
set :whenever_roles, [ :app ]

set :scm,           :git
set :copy_strategy, :checkout
set :git_strategy,  Capistrano::Git::SubmoduleStrategy
set :repo_url,      'git@github.com:chazelton331/yaybtc.git'
set :deploy_to,     '/data/app'

set :ssh_options,   { keepalive: true, forward_agent: true }
set :use_sudo,      true
set :pty,           false

set :linked_files,  fetch(:linked_files, []).push('config/database.yml')
set :linked_dirs,   fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

SSHKit.config.command_map[:rake ] = "bundle exec rake"
SSHKit.config.command_map[:rails] = "bundle exec rails"

set :log_level,       :debug
set :keep_releases,   5
set :bundle_binstubs, nil

set :default_env, { rvm_bin_path: '~/.rvm/bin' }

after "deploy:finished", "deploy:cleanup"
after "deploy:cleanup",  "deploy:restart"
