default[:layer_custom][:key] = ''
default[:layer_custom][:crt] = ''

if node[:opsworks][:stack]['elb-load-balancers'].size > 0
  default[:layer_custom][:es_host] = node[:opsworks][:stack]['elb-load-balancers'][0][:dns_name]
else
  default[:layer_custom][:es_host] = nil
end
