#
# Cookbook Name:: customtom
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "java-1.7.0-openjdk" do
	action :install
end

package "tomcat"  do
	action :install
end

package "tomcat-webapps" do
	action :install
end

package "tomcat-admin-webapps" do 
	action :install
end

template "/etc/tomcat/tomcat.conf" do
	source "tomcat.conf.erb"
	mode "0644"
	notifies :restart, 'service[tomcat]'
end

template "/etc/tomcat/tomcat-users.xml" do
	source "tomcat-users.xml.erb"
	mode "0644"
	notifies :restart, 'service[tomcat]'
end

service "tomcat" do
	action :start
end

bash 'deployment' do
	cwd '/usr/tomcat/webapps/'
	code <<-EOH
	wget https://tomcat.apache.org/tomcat-6.0-doc/appdev/sample/sample.war
	exit 0
	EOH
	returns [0, 1]
end
