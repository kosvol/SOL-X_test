# frozen_string_literal: true
# # require 'mysql2'
# module MariaDB_clearing
#   class << self

#     def clear_maria_db
#         begin
#         mariadb_host = $obj_env_yml['maria_db']['mariadb_host']
#         mariadb_user = $obj_env_yml['maria_db']['mariadb_user']
#         mariadb_pass = $obj_env_yml['maria_db']['mariadb_pass']
#         mariadb_database = $obj_env_yml['maria_db']['mariadb_database']

#         connect = Mysql2::Client.new(:host => mariadb_host,
#                                     :username => mariadb_user,
#                                     :password => mariadb_pass,
#                                     :database => mariadb_database)

#         connect.query("DELETE FROM replication.form where vesselId = 'sit-vessel'")
#         puts "The query has affected #{connect.affected_rows} rows"

#         rescue Mysql2::Error => e
#         puts e.errno
#         puts e.error

#         ensure
#         connect&.close
#         end
#     end
#   end
# end
