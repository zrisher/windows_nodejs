provides :windows_nodejs_app, os: 'windows' if respond_to?(:provides)

actions :create, :update, :delete
default_action :create

# need nil in kind_of?

config = node[:windows_nodejs][:app_defaults]

attribute :source, kind_of: String, required: true
attribute :revision, kind_of: String, required: true
attribute :ssh_key, kind_of: String, default: nil
attribute :app_root, kind_of: String, default: config[:deploy][:base_dir]
attribute :enable_submodules, kind_of: [TrueClass, FalseClass], default: true
attribute :depth, kind_of: Integer, default: 5
attribute :keep_releases, default: 5

attribute :deploy_user_name, kind_of: [String, NilClass],
          default: config[:deploy][:user][:name]
attribute :deploy_user_group, kind_of: [String, NilClass],
          default: config[:deploy][:user][:name]
attribute :deploy_user_home, kind_of: [String, NilClass],
          default: config[:deploy][:user][:home]
attribute :deploy_user_shell, kind_of: [String, NilClass],
          default: config[:deploy][:user][:shell]

attribute :migrate, kind_of: [TrueClass, FalseClass], default: true
attribute :migrate_command, kind_of: [String], default: nil

attribute :after_restart, kind_of: [Proc, String], default: nil
attribute :before_migrate, kind_of: [Proc, String], default: nil
attribute :before_restart, kind_of: [Proc, String], default: nil
attribute :before_symlink, kind_of: [Proc, String], default: nil

=begin
attribute :npm, kind_of: [NilClass, TrueClass, FalseClass], default: true
attribute :template, kind_of: [String, NilClass], default: nil
attribute :entry_point, kind_of: String, default: 'app.js'
attribute :service_name, kind_of: [String, NilClass], default: nil
=end