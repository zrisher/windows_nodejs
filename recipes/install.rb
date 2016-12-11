config = node['windows_nodejs']

windows_package config['package_name'] do
  version = config['install_version']

  source config['sources'][version]['url']
  checksum config['sources'][version]['checksum']
  action :install
end
