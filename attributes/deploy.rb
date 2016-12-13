default[:windows_nodejs][:deploy][:user][:name] = 'deploy'
default[:windows_nodejs][:deploy][:user][:group] = 'node_js'
default[:windows_nodejs][:deploy][:user][:home] = 'C:\\Users\\deploy'
default[:windows_nodejs][:deploy][:user][:shell] = 'C:\\Users\\deploy'

default[:windows_nodejs][:deploy][:releases_to_keep] = 5
default[:windows_nodejs][:deploy][:base_dir] = 'C:\\deploy'
default[:windows_nodejs][:deploy][:npm_install] = true
default[:windows_nodejs][:deploy][:npm_prune] = true
