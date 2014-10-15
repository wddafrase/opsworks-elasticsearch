node[:deploy].each do |application, deploy|
  template "#{deploy[:deploy_to]}/current/src/config.js" do
    source 'config.js.erb'
    mode 0660
    group deploy[:group]
    user deploy[:user]

    # first elb
    variables(eshost: node[:layer_custom][:es_host])
  end
end
