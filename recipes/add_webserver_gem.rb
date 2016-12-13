# check for stack version, seems to be stored somewhere in opsworks confuigration in node
# add unicorn or passenger gem, depending on which used
#
# *** Not yet tested for use in production ***
#
=begin
include_recipe 'deploy'
include_recipe 'deploy_rails'
web_intermediary = node[:opsworks][:rails_stack][:service]

if %w(unicorn passenger).include? web_intermediary
  node[:deploy].each do |application, deploy|
    Chef::Log.info "Looking for #{web_intermediary} in #{application}'s gemfile"
    app_root_path = "#{node[:deploy][application][:deploy_to]}/current"

    if File.exists? "#{app_root_path}/Gemfile"
      bundle_list = `cd #{app_root_path}; /usr/local/bin/bundle list`

      if bundle_list.include? web_intermediary
        Chef::Log.info 'Gemfile already correct.'

      else
        `echo 'gem "#{web_intermediary}"' >> #{app_root_path}/Gemfile`
        OpsWorks::RailsConfiguration.bundle(application, deploy, app_root_path)
        bundle_list = `cd #{app_root_path}; /usr/local/bin/bundle list`
        success = bundle_list.include? web_intermediary

        if success
          Chef::Log.info "Successfully added gem & installed gem #{web_intermediary} in #{application}, restarting."
          `sleep #{deploy[:sleep_before_restart]} && #{node[:opsworks][:rails_stack][:restart_command]}`
        else
          Chef::Log.error "Failed to add gem #{web_intermediary} in #{application}."
        end
      end

    else
      Chef::Log.error("No gemfile found.")

    end
  end
else
  Chef::Log.error("Unknown web intermediary #{web_intermediary}, skipping Gemfile check.")
end
=end



