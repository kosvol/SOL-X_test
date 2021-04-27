require 'pg'

module Postgres_clearing
    class << self

        def clear_postgres_db
            begin
                connection = PG::Connection.new(:host => $obj_env_yml['postgres']['host'], :user => $obj_env_yml['postgres']['username'], :dbname => $obj_env_yml['postgres']['database'], :port => '5432', :password => $obj_env_yml['postgres']['password'])
                puts 'Successfully created connection to database'

                # if $current_environment === 'sit'
                    connection.exec("DELETE FROM form WHERE id LIKE '%#{$current_environment.upcase}%';")
                    puts 'SIT vessel deleted'
                    connection.exec("DELETE FROM comment WHERE form_id LIKE '%SIT%';")
                    puts 'SIT comment deleted'
                # end

                resultSet = connection.exec("SELECT * FROM comment WHERE form_id LIKE '%SIT%';")
                resultSet.each do |row|
                    puts "Data row = #{row}"
                end
                            
            rescue PG::Error => e

                puts e.message 
                
            ensure

                connection.close if connection
                
            end
        end
    end
end