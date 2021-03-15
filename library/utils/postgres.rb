require 'pg'

module Postgres_clearing
    class << self

        def clear_postgres_db
            begin
                connection = PG::Connection.new(:host => $obj_env_yml['postgres']['host'], :user => $obj_env_yml['postgres']['username'], :dbname => $obj_env_yml['postgres']['database'], :port => '5432', :password => $obj_env_yml['postgres']['password'])
                puts 'Successfully created connection to database'

                connection.exec("SELECT * FROM form")
                resultSet = connection.exec("SELECT * FROM form WHERE id LIKE 'AUTO%';")
                resultSet.each do |row|
                    puts "Data row = #{row}"
                end

                if $current_environment === 'sit'
                    connection.exec('DELETE FROM form WHERE "vesselId" = %s;' % ['\'SIT%\''])
                    puts 'SIT vessel deleted'
                    connection.exec('DELETE FROM form WHERE "vesselId" = %s;' % ['\'LNGSIT%\''])
                    puts 'SIT LNG vessel deleted'
                end

                if $current_environment === 'auto'
                    # connection.exec('DELETE FROM form WHERE id LIKE %s;' % ['\'auto-lng-vessel\''])
                    # puts 'AUTO LNG vessel deleted'
                    connection.exec('DELETE FROM form WHERE id LIKE %s;' % ['\'AUTO%\''])
                    puts 'AUTO vessel deleted'
                end
                            
            rescue PG::Error => e

                puts e.message 
                
            ensure

                connection.close if connection
                
            end
        end
    end
end