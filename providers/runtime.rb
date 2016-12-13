use_inline_resources

provides :windows_nodejs_runtime, os: 'windows' if respond_to?(:provides)
def whyrun_supported?; true; end

action :create do
  config = node[:windows_nodejs][:runtime]

  # Determine platform architecture
  _arch = node[:kernel][:machine] =~ /x86_64/ ? 'x64' : 'x86'

  # Ensure version is properly formatted
  _version = Gem::Version.new(@new_resource.version || config[:version]).to_s

  # Generate the source URL if not provided
    _source = @new_resource.source || config[:source] ||
        "https://nodejs.org/dist/v#{_version}/node-v#{_version}-#{_arch}.msi"

  # Attempt to look up the checksum if not provided
    _checksum = @new_resource.checksum || config[:checksum] ||
        config[:checksums][_version][_arch]

  # Install using `windows` cookbook, deprecated but required for Chef < 12.6
    Chef::Log.info("Installing Node.js v#{_version} from #{_source}")
    windows_package 'Node.js' do
      version _version
      source _source
      checksum _checksum if respond_to?(:checksum)
      action :install
    end

  # Do we need to need to ensure there's only the correct Node.js in path?
  # Or does the package take care of this for us?
end






