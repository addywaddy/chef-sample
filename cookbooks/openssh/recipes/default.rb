#
# Cookbook Name:: openssh
# Recipe:: default
#
# Copyright 2008, OpsCode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

packages = case node[:platform]
  when "centos","redhat","fedora"
    %w{openssh-clients openssh}
  else
    %w{openssh-client openssh-server}
  end
  
packages.each do |pkg|
  package pkg
end

remote_file "/etc/ssh/sshd_config" do
  owner "root"
  group "root"
  mode 0644
  source "sshd_config"
end

service "ssh" do
  case node[:platform]
  when "centos","redhat","fedora"
    service_name "sshd"
  else
    service_name "ssh"
  end
  supports :restart => true
  action [ :enable, :restart ]
end

