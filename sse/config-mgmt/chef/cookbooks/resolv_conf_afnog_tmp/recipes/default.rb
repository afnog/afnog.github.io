

file '/tmp/resolv.conf' do
  owner 'afnog'
  group 'afnog'
  mode 0644
  action :create
  content <<-EOH
# Generated by chef @ #{Time.now.utc}
search sse.ws.afnog.org
nameserver 196.200.223.10
nameserver 4.4.4.4
nameserver 8.8.8.8
EOH

end

