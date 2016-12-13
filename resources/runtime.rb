provides :windows_nodejs_runtime, os: 'windows' if respond_to?(:provides)

actions :create
default_action :create

defaults = node[:windows_nodejs][:runtime][:defaults]
attribute :version, kind_of: String, default: defaults[:version]
attribute :source, kind_of: [String, nil], default: defaults[:source]
attribute :checksum, kind_of: [String, nil], default: defaults[:checksum]


