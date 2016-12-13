=begin
include_recipe 'deploy'
include_recipe 'deploy::rails'

node[:deploy].each do |application, deploy|
  execute "restart Rails app #{application}" do
    cwd deploy[:current_path]
    command node[:opsworks][:rails_stack][:restart_command]

    action :nothing
  end

  execute 'rake assets:precompile' do
    cwd deploy[:current_path]
    #user 'root' # deploy user because it has a umask of root, so created log files can't be written to
    command 'bundle exec rake assets:precompile'
    environment 'RAILS_ENV' => deploy[:static_assets][:compilation_env]

    #action :run
    notifies :run, "execute[restart Rails app #{application}]"
  end
end


# With md5-based references, you can set moderate cache lengths on CSS and JS and have built-in hotlinking protection.
# Amazing.
#
# I probably want to deploy these to a cdn no?
# No! Cloudfront can pull from custom origin servers now
# http://stackoverflow.com/questions/10745998/rails-how-to-upload-precompiled-assets-to-cloudfront
#
# The only case where this doesn't work is when someone loads a dated version of your page, cloudfront goes to fetch
# the file again, and it's no longer there because the md5 hash has changed and the original file was
# either deleted or on a different server. You could make the filename static, but then you lose the ability to
# easily invalidate older assets. That could be considered a feature.
#
# Also, once you start having a TON of servers or VERY large assets, it might make sense to only compile on one machine
# And sync with S3 as the origin using the asset_sync gem:
=begin
  'STATIC_FILE_BUCKET' => node[:environment_variables][:RAILS_ENV],
  'STATIC_FILE_DIR' => node[:environment_variables][:RAILS_ENV],
  'AWS_ACCESS_KEY_ID' => node[:environment_variables][:RAILS_ENV],
  'AWS_SECRET_ACCESS_KEY' => node[:environment_variables][:RAILS_ENV],
  'FOG_PROVIDER' => 'AWS',
  'FOG_REGION' => 'us-west-1',
  'ASSET_SYNC_GZIP_COMPRESSION' => 'true', #Serves ONLY gzips if available and smaller...
  'ASSET_SYNC_EXISTING_REMOTE_FILES' => 'keep',
  'ASSET_SYNC_MANIFEST' => 'true',
=end