CREATE DATABASE MYSQL_DB_NAME;
CREATE USER 'MYSQL_USER'@'%' IDENTIFIED BY 'MYSQL_USER_PASSWORD';
GRANT ALL PRIVILEGES ON MYSQL_DB_NAME.* TO 'MYSQL_USER'@'%';
FLUSH PRIVILEGES;
QUIT