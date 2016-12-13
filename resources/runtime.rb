provides :windows_nodejs_runtime, os: 'windows' if respond_to?(:provides)

actions :create
default_action :create

defaults = node[:windows_nodejs][:runtime][:defaults]

attribute :checksum, kind_of: [String, nil], default: defaults[:checksum]
attribute :source, kind_of: [String, nil], default: defaults[:source]
attribute :version, kind_of: String, default: defaults[:version],
          name_attribute: true, required: false


