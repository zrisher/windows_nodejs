Chef::Log.info('Starting windows_nodejs::install')
config = node['windows_nodejs']

# Determine platform architecture
_arch = node['kernel']['machine'] =~ /x86_64/ ? 'x64' : 'x86'

# Ensure version is properly formatted
_version = Gem::Version.new(config['version']).to_s

# Generate the source URL if not provided
_source = config['source'] ||
    "https://nodejs.org/dist/v#{_version}/node-v#{_version}-#{_arch}.msi"

# Attempt to look up the checksum if not provided
_checksum = config['checksum'] || config['checksums'][version][arch]

# Install using `windows` cookbook, deprecated but required for Chef < 12.6
Chef::Log.info("Installing Node.js v#{_version} from #{_source}")
windows_package 'Node.js' do
  version _version
  source _source
  checksum _checksum if respond_to?(:checksum)
  action :install
end

