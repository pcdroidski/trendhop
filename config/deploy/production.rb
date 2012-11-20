set :deploy_to, "/var/www/production/trendhop/"

server "##.##.###.##", :app, :web
role :db,  "###.###.###.##", :primary => true
