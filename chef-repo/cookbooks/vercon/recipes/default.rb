#
# Cookbook Name:: vercon
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bash 'Uninstallation&Installation' do
	cwd '/etc/yum.repos.d/'
	code <<-EOH
	rm -rf local_java.repo
	yum remove java
	yum install -y java-1.7.0-openjdk.x86_64
	yum install -y java-1.7.0-openjdk-devel
	
	exit 0
	EOH
	returns [0, 1]
end