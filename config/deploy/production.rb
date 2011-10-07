set :deploy_to, "/var/www/production/trendhop/"

server "66.228.43.164", :app, :web
role :db,  "66.228.43.164", :primary => true
