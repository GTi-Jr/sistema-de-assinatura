# config valid only for current version of Capistrano
lock '3.6.1'




#test
set :bundle_binstubs, nil
set :application, 'caixa_cegonha'
set :repo_url, 'git@github.com:GTi-Jr/sistema-de-assinatura.git' # Edit this to match your repository
set :branch, :cancel_test_fix
set :user, 'deploy'
set :deploy_to, '/home/deploy/caixa_cegonha'
set :pty, true
set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :keep_releases, 5
set :rvm_type, :user
#set :rvm_version, '1.27.0'
set :rvm_ruby, '1.0.0' # Edit this if you are using MRI Ruby

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 8]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, false



namespace :deploy do
  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
  end
end

=begin

  desc "Open the rails console on primary app server"
  task :console do
    on roles(:app), primary: true do
      rails_env = fetch(:stage)
      execute_interactively "#{bundle_cmd} rails console #{rails_env}"
    end
  end


desc "Open the rails dbconsole on primary db server"
  task :dbconsole do
    on roles(:db), primary: true do
      rails_env = fetch(:stage)
      execute_interactively "#{bundle_cmd} rails dbconsole #{rails_env}"
    end
  end
namespace :rails do
  desc "Run the console on a remote server."
  task :console do
    on roles(:app) do |h|
      execute_interactively "RAILS_ENV=#{fetch(:rails_env)} bundle exec rails console", h.user
    end
  end

  def execute_interactively(command)
    user = fetch(:user)

    info "Connecting with #{user}@#{host}"
    cmd = "ssh #{user}@#{host} -p 22 -t 'cd #{fetch(:deploy_to)}/current && #{command}'"
    exec cmd
  end
end


def bundle_cmd
  if fetch(:rbenv_ruby)
    # FIXME: Is there a better way to do this? How does "execute :bundle" work?
    "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{File.join(fetch(:rbenv_path), '/bin/rbenv')} exec bundle exec"
  else
    "ruby "
  end
end
=end

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
