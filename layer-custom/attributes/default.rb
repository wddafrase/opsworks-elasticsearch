default[:layer_custom][:key] = ''
default[:layer_custom][:crt] = ''
default[:layer_custom][:es_host] = node[:opsworks][:stack]['elb-load-balancers'][0][:dns_name]
