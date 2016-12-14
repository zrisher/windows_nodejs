require 'securerandom'

use_inline_resources

provides :windows_nodejs_app, os: 'windows' if respond_to?(:provides)
def whyrun_supported?; true; end


action :create do
  r = new_resource
  Chef::Log.info "windows_nodejs::app:create name: #{r.name}"

  # Deploy User
  user r.deploy_user_name do
    comment                    'NodeJS Deploy Agent'
    home                       r.deploy_user_home
    shell                      r.deploy_user_shell
    password                   new_windows_password
    manage_home                true
  end

  group r.deploy_user_group do
    members                    [r.deploy_user_name]
    append                     true
  end

  # Deploy Key
  ssh_wrapper = nil
  if r.ssh_key
    key_path = "#{r.deploy_user_home}/.ssh/#{r.name}_repo_key"

    file key_path do
      content r.ssh_key
    end

    ssh_wrapper = "ssh -i #{key_path}"
  end
  Chef::Log.info "windows_nodejs::app:create ssh_key: #{r.ssh_key}"
  Chef::Log.info "windows_nodejs::app:create ssh_wrapper: #{ssh_wrapper}"

  # Deploy
  deploy r.name do
    user                       r.deploy_user_name
    group                      r.deploy_user_group
    repository                 r.source
    revision                   r.revision
    ssh_wrapper                ssh_wrapper if ssh_wrapper.present?
    deploy_to                  "#{r.apps_dir}//#{r.name}"
    keep_releases              r.keep_releases
    depth                      r.depth
    enable_submodules          r.enable_submodules

    after_restart              r.after_restart
    before_migrate             r.before_migrate
    before_restart             r.before_restart
    before_symlink             r.before_symlink
  end

  # Exec User
  user r.exec_user_name do
    comment                    'NodeJS Exec Agent'
    home                       r.exec_user_home
    shell                      r.exec_user_shell
    password                   new_windows_password
    manage_home                true
  end

  group r.exec_user_group do
    members                    [r.exec_user_name]
    append                     true
  end

end



def new_windows_password(length=16)
  pass = SecureRandom.urlsafe_base64(length)[0, length-1]

  until (pass =~ /[0-9]/ && pass =~ /[A-Z]/ && pass =~ /[A-Z]/) do
    pass = SecureRandom.urlsafe_base64(length)[0, length-1]
  end

  pass
end



=begin
    environment                Hash

    migrate                    r.migrate
    migration_command          r.migration_command

    create_dirs_before_symlink Array
    purge_before_symlink       Array
    symlinks                   Hash
    symlink_before_migrate     Hash

    restart_command            Proc, String

    rollback_on_error          TrueClass, FalseClass
=end

  # ensure node installed

  # npm install
=begin
  execute 'npm install' do
    cwd new_resource.release_path
    user new_resource.owner
    group new_resource.group
    only_if { new_resource.npm }
    environment new_resource.environment.merge('HOME' => new_resource.shared_path)
  end
=end

  # setup service
=begin
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
=end
=begin
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
=end


  # 'NODE_ENV' => new_resource.environment_name

