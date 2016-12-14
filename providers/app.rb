use_inline_resources

provides :windows_nodejs_app, os: 'windows' if respond_to?(:provides)
def whyrun_supported?; true; end


action :create do
  Chef::Log.info "windows_nodejs::app:create name: #{new_resource.name}"
end


=begin
include Chef::DSL::IncludeRecipe

action :before_compile do
  include_recipe 'nodejs::install'

  include_recipe 'nodejs::npm' if new_resource.npm

  service_name = if new_resource.service_name.nil?
                   new_resource.application.name
                 else
                   new_resource.service_name
                 end

  service_name = if new_resource.service_name.nil?
                   new_resource.application.name
                 else
                   new_resource.service_name
                 end

  r = new_resource
  unless r.restart_command
    r.restart_command do
      service "#{service_name}_nodejs" do
        provider Chef::Provider::Service::Upstart
        supports restart: true, start: true, stop: true
        action [:enable, :restart]
      end
    end
  end

  new_resource.environment.update('NODE_ENV' => new_resource.environment_name)
  new_resource.updated_by_last_action(true)
end

action :before_deploy do
  new_resource.environment['NODE_ENV'] = new_resource.environment_name
  new_resource.updated_by_last_action(true)
end

action :before_migrate do
  execute 'npm install' do
    cwd new_resource.release_path
    user new_resource.owner
    group new_resource.group
    only_if { new_resource.npm }
    environment new_resource.environment.merge('HOME' => new_resource.shared_path)
  end
  new_resource.updated_by_last_action(true)
end

action :before_symlink do
  new_resource.updated_by_last_action(true)
end

action :before_restart do
  node_binary = ::File.join(node['nodejs']['dir'], 'bin', 'node')

  service_name = if new_resource.service_name.nil?
                   new_resource.application.name
                 else
                   new_resource.service_name
                 end

  template "#{service_name}.upstart.conf" do
    path "/etc/init/#{service_name}_nodejs.conf"
    source new_resource.template ? new_resource.template : 'nodejs.upstart.conf.erb'
    cookbook new_resource.template ? new_resource.cookbook_name.to_s : 'application_nodejs'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
        user: new_resource.owner,
        group: new_resource.group,
        node_binary: node_binary,
        app_dir: ::File.join(new_resource.path, 'current'),
        entry: new_resource.entry_point,
        environment: new_resource.environment
    )
  end
  new_resource.updated_by_last_action(true)
end

action :after_restart do
  new_resource.updated_by_last_action(true)
end
=end