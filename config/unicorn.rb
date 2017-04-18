worker_processes   4
working_directory "/data/app/current"
listen            "/data/app/shared/app-unicorn.sock", backlog: 64
listen            8080, tcp_nopush: true
timeout           30
pid               "/data/app/shared/tmp/pids/unicorn.pid"
stderr_path       "/data/app/shared/log/unicorn.stderr.log"
stdout_path       "/data/app/shared/log/unicorn.stdout.log"
preload_app       true

if GC.respond_to?(:copy_on_write_friendly=)
  GC.copy_on_write_friendly = true
end

check_client_connection false

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  old_pid = "#{server.config[:pid]}.oldbin"

  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection(Rails.application.config.database_configuration[Rails.env])
  end
end

before_exec do |server|
  gemfile = "/data/app/current/Gemfile"

  if File.exists?(gemfile)
    ENV['BUNDLE_GEMFILE'] = gemfile
  end
end
