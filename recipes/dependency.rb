#
## Cookbook Name:: teagent
## Recipe:: dependency
#
# Copyright © 2013 ThousandEyes, Inc.
#

case node['platform']
when 'debian'
    if node[:platform_version].to_f >= 6 and node[:platform_version].to_f < 7
        package 'lsb-release' do
            action :install
        end
        include_recipe 'teagent::repository'
    else
        Chef::Application.fatal!('Only Debian 6 (squeeze - 6.x) is supported. Please contact support.')
    end
when 'ubuntu'
    case node[:platform_version]
    when '10.04', '12.04', '14.04'
        package 'lsb-release' do
            action :install
        end
        include_recipe 'teagent::repository'
    else
        Chef::Application.fatal!('Only Ubuntu 10.4 (lucid), 12.04 (precise) and 14.04(trusty) are supported. Please contact support.')
    end
when 'rhel','redhat','centos'
    if node[:platform_version].to_f >= 6.3
        include_recipe 'teagent::repository'
    else
        Chef::Application.fatal!("Please upgrade your operating system (#{node['platform']}) to >= 6.3")
    end
else
    Chef::Application.fatal!("#{node['platform']} isn't supported.")
end

