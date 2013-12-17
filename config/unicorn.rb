# config/unicorn.rb
rails_env = ENV['RAILS_ENV'] || 'production'  
rails_root  = `pwd`.gsub("\n", "")

worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true
listen      3000
pid         "#{rails_root}/tmp/pids/unicorn.pid"
#stderr_path "#{rails_root}/log/unicorn.log"
#stdout_path "#{rails_root}/log/unicorn.log"

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end
