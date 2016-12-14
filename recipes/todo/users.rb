

group 'Administrators' do
  members ['domain\foo']
  append true
  action :modify
end

user 'node_js' do
  comment                    'Node.js process user'
  gid                        '1234'
  home                       '/home/random'
  manage_home                true
  notifies                   # see description
  password                   String
  shell                      String
  subscribes                 # see description
  system                     TrueClass, FalseClass
  uid                        String, Integer
  username                   String # defaults to 'name' if not specified
  action                     :create
end


# G(MWS,w;dWZE3[@GVc_!E8Cy


