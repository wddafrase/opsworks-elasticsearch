# add repository
apt_repository 'logstash' do
  uri 'http://packages.elasticsearch.org/logstash/1.4/debian'
  key 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch'
  distribution 'stable'
  components 'main'
end

# install package
package 'logstash'

# get logstash contrib deb
logstash_contrib_dir = '/tmp/logstash-contrib_1.4.2-1-efd53ef_all.deb'
remote_file logstash_contrib_dir do
  source 'https://download.elasticsearch.org/logstash/logstash/packages/debian/logstash-contrib_1.4.2-1-efd53ef_all.deb'
  mode 0644
end

# install deb file
dpkg_package 'logstash-contrib' do
  source logstash_contrib_dir
  action :install
end


# download lumberjack key
remote_file '/opt/logstash/lumberjack.key' do
  owner 'root'
  group 'root'
  mode 0644
  source node[:layer_custom][:key]
end
remote_file '/opt/logstash/lumberjack.crt' do
  owner 'root'
  group 'root'
  mode 0644
  source node[:layer_custom][:crt]
end


service 'logstash' do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end


# add nginx pattern
template 'nginx_pattern.erb' do
  path '/opt/logstash/pattern/nginx'
  source 'nginx_pattern.erb'
  owner 'root'
  mode 0644
end

# setup config
template 'logstash.conf.erb' do
  path '/etc/logstash/conf.d/logstash.conf'
  source 'logstash.conf.erb'
  owner 'root'
  mode 0644
  notifies :restart, 'service[logstash]', :immediately
  variables(eshost: node[:opsworks][:stack]['elb-load-balancers'][0][:dns_name])
end
