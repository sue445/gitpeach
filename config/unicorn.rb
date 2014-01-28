# Sample configuration file for Unicorn (not Rack)
#
# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# documentation.

APP_DIR = File.expand_path("../../", __FILE__)

# Use at least one worker per core if you're on a dedicated server,
# more will usually help for _short_ waits on databases/caches.
worker_processes 4

# Help ensure your application will always spawn in the symlinked
# "current" directory that Capistrano sets up.
# working_directory "<%= unicorn_working_directory %>" # available in 0.94.0+

# listen on both a Unix domain socket and a TCP port,
# we use a shorter backlog for quicker failover when busy
listen "#{APP_DIR}/tmp/unicorn.sock", :backlog => 128
listen 8080, :tcp_nopush => true

# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 30

# feel free to point this anywhere accessible on the filesystem
#pid '/tmp/pids/unicorn.pid'

# some applications/frameworks log to stderr or stdout, so prevent
# them from going to /dev/null when daemonized here:
stderr_path "#{APP_DIR}/log/unicorn.stderr.log"
stdout_path "#{APP_DIR}/log/unicorn.stdout.log"

# combine REE with "preload_app true" for memory savings
# http://rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and  GC.copy_on_write_friendly = true

before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  defined?(ActiveRecord::Base) and    ActiveRecord::Base.connection.disconnect!
  defined?(Resque) and Resque.redis and Resque.redis.client.disconnect

  # The following is only recommended for memory/DB-constrained
  # installations.  It is not needed if your system can house
  # twice as many worker_processes as you have configured.

  # This allows a new master process to incrementally
  # phase out the old master process with SIGTTOU to avoid a
  # thundering herd (especially in the "preload_app false" case)
  # when doing a transparent upgrade.  The last worker spawned
  # will then kill off the old master process with a SIGQUIT.
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end

  # # *optionally* throttle the master from forking too quickly by sleeping
  # sleep 1
end

after_fork do |server, worker|
  # per-process listener ports for debugging/admin/migrations
  # addr = "127.0.0.1:#{9293 + worker.nr}"
  # server.listen(addr, :tries => -1, :delay => 5, :tcp_nopush => true)

  # the following is *required* for Rails + "preload_app true",
  defined?(ActiveRecord::Base) and    ActiveRecord::Base.establish_connection
  # TODO uncomment out
  #defined?(Resque) and Resque.redis and Resque.redis.client.connect

  # if preload_app is true, then you may also want to check and  # restart any other shared sockets/descriptors such as Memcached,
  # and Redis.  TokyoCabinet file handles are safe to reuse
  # between any number of forked children (assuming your kernel correctly implements pread()/pwrite() system calls)
  # worker.user("<%= unicorn_user %>", "<%= unicorn_group %>") if Process.euid == 0
end
