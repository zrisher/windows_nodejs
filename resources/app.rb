provides :windows_nodejs_app, os: 'windows' if respond_to?(:provides)

actions :create, :update, :delete
default_action :create

config = node[:windows_nodejs][:deploy]
attribute :source, kind_of: String, required: true
attribute :revision, kind_of: String
attribute :ssh_key, kind_of: String
attribute :apps_dir, kind_of: String, default: config[:apps_dir]
attribute :keep_releases, kind_of: Integer, default: config[:keep_releases]
attribute :depth, kind_of: Integer, default: config[:depth]
attribute :enable_submodules, kind_of: [TrueClass, FalseClass],
          default: config[:enable_submodules]

deploy_user = config[:user]
attribute :deploy_user_name,  kind_of: String, default: deploy_user[:name]
attribute :deploy_user_group, kind_of: String, default: deploy_user[:group]
attribute :deploy_user_home,  kind_of: String, default: deploy_user[:home]
attribute :deploy_user_shell, kind_of: String, default: deploy_user[:shell]

exec_user = node[:windows_nodejs][:exec][:user]
attribute :exec_user_name,  kind_of: String, default: exec_user[:name]
attribute :exec_user_group, kind_of: String, default: exec_user[:group]
attribute :exec_user_home,  kind_of: String, default: exec_user[:home]
attribute :exec_user_shell, kind_of: String, default: exec_user[:shell]

attribute :after_restart, kind_of: [Proc, String]
attribute :before_migrate, kind_of: [Proc, String]
attribute :before_restart, kind_of: [Proc, String]
attribute :before_symlink, kind_of: [Proc, String]



=begin
attribute :migrate, kind_of: [TrueClass, FalseClass], default: true
attribute :migrate_command, kind_of: [String], default: nil
=end