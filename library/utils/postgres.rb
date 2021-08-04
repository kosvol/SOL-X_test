require 'pg'

module Postgres_clearing
    class << self

        def clear_postgres_db(env)
            begin
                connection = PG::Connection.new(:host => $obj_env_yml['postgres']['host'], :user => $obj_env_yml['postgres']['username'], :dbname => $obj_env_yml['postgres']['database'], :port => '5432', :password => $obj_env_yml['postgres']['password'])
                puts 'Successfully created connection to database'

                connection.exec("DELETE FROM form WHERE id LIKE '%#{env.upcase}%';")
                puts 'SIT vessel deleted'
                connection.exec("DELETE FROM comment WHERE form_id LIKE '%#{env.upcase}%';")
                puts 'SIT comment deleted'

                resultSet = connection.exec("SELECT * FROM comment WHERE form_id LIKE '%#{env.upcase}%';")
                resultSet.each do |row|
                    puts "Comment data row = #{row}"
                end

                resultSet = connection.exec("SELECT * FROM form WHERE id LIKE '%#{env.upcase}%';")
                resultSet.each do |row|
                    puts "Form data row = #{row}"
                end
                            
            rescue PG::Error => e
                puts e.message 
            ensure
                connection.close if connection
            end
        end

        # def import_step_record_csv_postgres
        #     begin
        #         connection = PG::Connection.new(:host => $obj_env_yml['postgres']['host'], :user => $obj_env_yml['postgres']['username'], :dbname => $obj_env_yml['postgres']['database'], :port => '5432', :password => $obj_env_yml['postgres']['password'])
        #         puts 'Successfully created connection to database'
                
        #         connection.exec("TRUNCATE public.steps_report RESTART IDENTITY;")
        #         puts 'Step record table TRUNCATED'
        #         resultSet = connection.exec("COPY public.steps_report (id, user_id, vessel_id, timestamp_start, timestamp_end, utc_offset, steps, crew_rank) FROM '/Users/slo-gx/steps_report.csv' DELIMITER ',' CSV ENCODING 'UTF8' QUOTE '\"' ESCAPE '''';")
        #         # resultSet = connection.exec("COPY persons(user_id, vessel_id, timestamp_start, timestamp_end, utc_offset, steps, crew_rank) FROM '/Users/slo-gx/steps_report.csv' DELIMITER ',' CSV HEADER;")
        #         puts 'Dump into step record table'
        #         resultSet.each do |row|
        #             puts "Post result: #{row}"
        #         end
        #     rescue PG::Error => e
        #         puts e.message
        #     ensure
        #         connection.close if connection
        #     end
        # end
    end
end