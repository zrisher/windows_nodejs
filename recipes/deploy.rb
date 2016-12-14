apps = node[:windows_nodejs][:apps]
defaults = node[:windows_nodejs][:app_defaults]


apps.each do |name, config|
  windows_nodejs_app name do
    action :create
  end
end


=begin




default[:deploy][application][:deploy_to] = "/srv/www/#{application}"



# The deploy provider used. Set to one of
# - "Branch"      - enables deploy_branch (Chef::Provider::Deploy::Branch)
# - "Revision"    - enables deploy_revision (Chef::Provider::Deploy::Revision)
# - "Timestamped" - enables deploy (default, Chef::Provider::Deploy::Timestamped)
# Deploy provider can also be set at application level.
default[:opsworks][:deploy_chef_provider] = 'Timestamped'

valid_deploy_chef_providers = ['Timestamped', 'Revision', 'Branch']
unless valid_deploy_chef_providers.include?(node[:opsworks][:deploy_chef_provider])
  raise "Invalid deploy_chef_provider: #{node[:opsworks][:deploy_chef_provider]}. Valid providers: #{valid_deploy_chef_providers.join(', ')}."
end




default[:deploy][application][:chef_provider] = node[:deploy][application][:chef_provider] ? node[:deploy][application][:chef_provider] : node[:opsworks][:deploy_chef_provider]
unless valid_deploy_chef_providers.include?(node[:deploy][application][:chef_provider])
  raise "Invalid chef_provider '#{node[:deploy][application][:chef_provider]}' for app '#{application}'. Valid providers: #{valid_deploy_chef_providers.join(', ')}."
end
default[:deploy][application][:keep_releases] = node[:deploy][application][:keep_releases] ? node[:deploy][application][:keep_releases] : node[:opsworks][:deploy_keep_releases]
default[:deploy][application][:current_path] = "#{node[:deploy][application][:deploy_to]}/current"
default[:deploy][application][:document_root] = ''
default[:deploy][application][:ignore_bundler_groups] = node[:opsworks][:rails][:ignore_bundler_groups]
if deploy[:document_root]
  default[:deploy][application][:absolute_document_root] = "#{default[:deploy][application][:current_path]}/#{deploy[:document_root]}/"
else
  default[:deploy][application][:absolute_document_root] = "#{default[:deploy][application][:current_path]}/"
end



default[:deploy][application][:purge_before_symlink] = ['log', 'tmp/pids', 'public/system']
default[:deploy][application][:create_dirs_before_symlink] = ['tmp', 'public', 'config']
default[:deploy][application][:symlink_before_migrate] = {}
default[:deploy][application][:symlinks] = {"system" => "public/system", "pids" => "tmp/pids", "log" => "log"}

default[:deploy][application][:environment] = {"RAILS_ENV" => deploy[:rails_env],
                                               "RUBYOPT" => "",
                                               "RACK_ENV" => deploy[:rails_env],
                                               "HOME" => node[:deploy][application][:home]}


include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'nodejs'
    Chef::Log.debug("Skipping deploy::nodejs for application #{application} as it is not a node.js app")
    next
  end

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end

  opsworks_nodejs do
    deploy_data deploy
    app application
  end

  application_environment_file do
    user deploy[:user]
    group deploy[:group]
    path ::File.join(deploy[:deploy_to], "shared")
    environment_variables deploy[:environment_variables]
  end

  ruby_block "restart node.js application #{application}" do
    block do
      Chef::Log.info("restart node.js via: #{node[:deploy][application][:nodejs][:restart_command]}")
      Chef::Log.info(`#{node[:deploy][application][:nodejs][:restart_command]}`)
      $? == 0
    end
  end
end


compile assets?

node[:deploy].each do |application, deploy|
  execute "restart Rails app #{application}" do
    cwd deploy[:current_path]
    command node[:opsworks][:rails_stack][:restart_command]

    action :nothing
  end

  execute 'rake assets:precompile' do
    cwd deploy[:current_path]
    #user 'root' # deploy user because it has a umask of root, so created log files can't be written to
    command 'bundle exec rake assets:precompile'
    environment 'RAILS_ENV' => deploy[:static_assets][:compilation_env]

    #action :run
    notifies :run, "execute[restart Rails app #{application}]"
  end
end

=end