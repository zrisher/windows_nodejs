provides :windows_nodejs_app, os: 'windows' if respond_to?(:provides)

actions :create, :update, :delete
default_action :create



config = node[:windows_nodejs][:app_defaults] = {
  deploy: {
    base_dir: 'C:\\nodejs\\apps',
    npm_install: true,
    npm_prune: true,
    releases_to_keep: 5,
    user: {
      name: 'deploy',
      group: 'node_js',
      home: 'C:\\Users\\deploy',
      shell: 'C:\\Users\\deploy'
    }
  },
  execute: {
    env: 'production',
    env_vars: {}
  },
  service: {

  }
}


attribute :deploy_user_name, kind_of: [String, NilClass],
          default: config[:deploy][:user][:name]
attribute :deploy_user_group, kind_of: [String, NilClass],
          default: config[:deploy][:user][:name]
attribute :deploy_user_home, kind_of: [String, NilClass],
          default: config[:deploy][:user][:home]
attribute :deploy_user_shell, kind_of: [String, NilClass],
          default: config[:deploy][:user][:shell]

attribute :after_restart, kind_of: [Proc, String], default: nil
attribute :before_migrate, kind_of: [Proc, String], default: nil
attribute :before_restart, kind_of: [Proc, String], default: nil
attribute :before_symlink, kind_of: [Proc, String], default: nil

attribute :source, kind_of: String, required: true
attribute :revision, kind_of: String, required: true

# need nil in kind_of?
attribute :migrate, kind_of: [TrueClass, FalseClass], default: true
attribute :migrate_command, kind_of: [String], default: nil

attribute :ssh_key, kind_of: String, default: nil

attribute :repo, kind_of: String, default: nil

attribute :enable_submodules, kind_of: [TrueClass, FalseClass], default: true
attribute :depth, kind_of: Integer, default: 5
attribute :keep_releases, default: 5




attribute :app_root, kind_of: String, default: config[:deploy][:base_dir]



=begin
attribute :npm, kind_of: [NilClass, TrueClass, FalseClass], default: true
attribute :template, kind_of: [String, NilClass], default: nil
attribute :entry_point, kind_of: String, default: 'app.js'
attribute :service_name, kind_of: [String, NilClass], default: nil
=end