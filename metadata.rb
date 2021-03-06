name             'windows_nodejs'
version          '0.0.1'
maintainer       'Zach Risher'
maintainer_email 'zrisher@yahoo.com'
description      'Manages Node.js on Windows'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
license          'MIT'
source_url       'https://github.com/zrisher/windows_nodejs'
issues_url       'https://github.com/zrisher/windows_nodejs/issues'
supports         'windows'
chef_version     '~> 12' if respond_to?(:chef_version) # Chef 12.2
depends          'windows'
