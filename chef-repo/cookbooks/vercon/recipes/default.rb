#
# Cookbook Name:: vercon
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME

# All rights reserved - Do Not Redistribute

bash 'Uninstallation&Installation' do
	cwd '/etc/yum.repos.d/'
	code <<-EOH
	rm -rf local_java.repo
	yum remove java
	yum install -y java-1.7.0-openjdk.x86_64
	yum install -y java-1.7.0-openjdk-devel
	export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk.x86_64/bin/javac
	EOH
	returns [0, 1]
end

bash 'InstallionOfMaven' do
	cwd '/opt/'
	code <<-EOH
	wget https://archive.apache.org/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.zip
	yum install -y unzip
	unzip apache-maven-3.3.3-bin.zip
	mv apache-maven-3.3.3 maven
	ln -s /opt/maven/bin/mvn /usr/bin/mvn
	cd /etc/profile.d/
	touch maven.sh
	echo '#!/bin/bash' > maven.sh
	echo 'MAVEN_HOME=/var/maven' >> maven.sh
	echo 'PATH=$MAVEN_HOME/bin:$PATH' >> maven.sh
	echo 'export PATH MAVEN_HOME' >> maven.sh
	echo 'export CLASSPATH=.' >> maven.sh
	chmod +x /etc/profile.d/maven.sh
	source /etc/profile.d/maven.sh
	mvn -version
	exit 0
	EOH
	returns [0, 1]
end

bash 'Jenkins Installtion' do
	cwd '/tmp'
	code <<-EOH
	wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
	rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
	exit 0
	EOH
	returns [0, 1]
end

package 'jenkins' do
	action :install
end

service 'jenkins' do
	action :start
end