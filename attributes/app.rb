default[:windows_nodejs][:deploy][:apps_dir] = 'C:\\apps'
default[:windows_nodejs][:deploy][:keep_releases] = 5
default[:windows_nodejs][:deploy][:enable_submodules] = true
default[:windows_nodejs][:deploy][:depth] = 5

default[:windows_nodejs][:deploy][:user][:name] = 'nodejs_deploy'
default[:windows_nodejs][:deploy][:user][:group] = 'nodejs'
default[:windows_nodejs][:deploy][:user][:home] = 'C:\\Users\\nodejs_deploy'
default[:windows_nodejs][:deploy][:user][:shell] = 'C:\\Users\\nodejs_deploy'

default[:windows_nodejs][:exec][:user][:name] = 'nodejs_exec'
default[:windows_nodejs][:exec][:user][:group] = 'nodejs'
default[:windows_nodejs][:exec][:user][:home] = 'C:\\Users\\nodejs_exec'
default[:windows_nodejs][:exec][:user][:shell] = 'C:\\Users\\nodejs_exec'


=begin

default[:windows_nodejs][:deploy][:npm_install] = true
default[:windows_nodejs][:deploy][:npm_prune] = true

default[:windows_nodejs][:exec][:env] = 'production'
default[:windows_nodejs][:exec][:env_vars] = {}


=end


default[:windows_nodejs][:apps] = {}
# Override config defaults per app, for example:
#normal[:windows_nodejs][:apps][:example_app][:deploy][:releases_to_keep] = 10
