use_inline_resources

provides :windows_nodejs_runtime, os: 'windows' if respond_to?(:provides)
def whyrun_supported?; true; end

action :create do

  # Determine platform architecture
  _arch = node[:kernel][:machine] =~ /x86_64/ ? 'x64' : 'x86'

  # Ensure version is properly formatted
  _version = Gem::Version.new(@new_resource.version).to_s

  # Generate the source URL if not provided
  _source = @new_resource.source ||
      "https://nodejs.org/dist/v#{_version}/node-v#{_version}-#{_arch}.msi"

  # Attempt to look up the checksum if not provided
  checksums = node[:windows_nodejs][:runtime][:checksums]
  _checksum = @new_resource.checksum || checksums[_version][_arch]

  # Install using `windows` cookbook, deprecated but required for Chef < 12.6
  Chef::Log.info("Ensuring Node.js v#{_version}")
  windows_package 'Node.js' do
    version _version
    source _source
    checksum _checksum if respond_to?(:checksum)
    action :install
  end

  # Do we need to need to ensure there's only the correct Node.js in path?
  # Or does the package take care of this for us?
end






