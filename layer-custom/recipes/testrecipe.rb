#
# Cookbook Name:: layer-custom
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.
file '/tmp/test_file' do
  content 'hello world!'
end
