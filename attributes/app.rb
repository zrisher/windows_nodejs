default[:windows_nodejs][:deploy][:base_dir] = 'C:\\apps'
default[:windows_nodejs][:deploy][:npm_install] = true
default[:windows_nodejs][:deploy][:npm_prune] = true
default[:windows_nodejs][:deploy][:keep_releases] = 5
default[:windows_nodejs][:deploy][:user][:name] = 'nodejs_deploy'
default[:windows_nodejs][:deploy][:user][:group] = 'nodejs'
default[:windows_nodejs][:deploy][:user][:home] = 'C:\\Users\\nodejs_deploy'
default[:windows_nodejs][:deploy][:user][:shell] = 'C:\\Users\\nodejs_deploy'


default[:windows_nodejs][:execute][:env] = 'production'
default[:windows_nodejs][:execute][:env_vars] = {}
default[:windows_nodejs][:execute][:user][:name] = 'nodejs_exec'
default[:windows_nodejs][:execute][:user][:group] = 'nodejs'
default[:windows_nodejs][:execute][:user][:home] = 'C:\\Users\\nodejs_exec'
default[:windows_nodejs][:execute][:user][:shell] = 'C:\\Users\\nodejs_exec'


default[:windows_nodejs][:apps] = {}
# Override config defaults per app, for example:
#normal[:windows_nodejs][:apps][:example_app][:deploy][:releases_to_keep] = 10
