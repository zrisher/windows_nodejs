provides :windows_nodejs_runtime, os: 'windows' if respond_to?(:provides)

actions :create
default_action :create

attribute :version,  kind_of: String, name_attribute: true
attribute :source, kind_of: [String, nil], default: nil
attribute :checksum, kind_of: [String, nil], default: nil


