node[:deploy].each do |app_name, deploy|
  execute "mysql-create-table" do
    command "/usr/bin/mysql -u#{deploy[:database][:username]} -p#{deploy[:database][:password]} #{deploy[:database][:database]} -e'CREATE TABLE #{node[:userapp][:dbtable]}(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    email varchar(255),
    PRIMARY KEY (id)
  )'"
    not_if "/usr/bin/mysql -u#{deploy[:database][:username]} -p#{deploy[:database][:password]} #{deploy[:database][:database]} -e'SHOW TABLES' | grep #{node[:userapp][:dbtable]}"
    action :run
  end
end
