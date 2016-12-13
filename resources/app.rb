provides :windows_nodejs_app, os: 'windows' if respond_to?(:provides)

actions :create
default_action :create


=begin
include ApplicationCookbook::ResourceBase

actions :before_compile, :before_deploy, :before_migrate, :before_symlink, :before_restart, :after_restart

default_action :before_compile

attribute :npm, kind_of: [NilClass, TrueClass, FalseClass], default: true
attribute :template, kind_of: [String, NilClass], default: nil
attribute :entry_point, kind_of: String, default: 'app.js'
attribute :service_name, kind_of: [String, NilClass], default: nil

=end