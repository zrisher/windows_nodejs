=begin

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'nodejs'
    Chef::Log.debug("Skipping deploy::nodejs-undeploy for application #{application} as it is not a node.js app")
    next
  end

  ruby_block "stop node.js application #{application}" do
    block do
      Chef::Log.info("stop node.js via: #{node[:deploy][application][:nodejs][:stop_command]}")
      Chef::Log.info(`#{node[:deploy][application][:nodejs][:stop_command]}`)
      $? == 0
    end
  end

end


default[:deploy][application][:nodejs][:restart_command] = "monit restart node_web_app_#{application}"
default[:deploy][application][:nodejs][:stop_command] = "monit stop node_web_app_#{application}"

=end