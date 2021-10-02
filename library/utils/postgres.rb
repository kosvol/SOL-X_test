# frozen_string_literal: true

require 'pg'

module Postgres_clearing
  class << self
    def clear_postgres_db(env)
      connection = PG::Connection.new(host: $obj_env_yml['postgres']['host'],
                                      user: $obj_env_yml['postgres']['username'],
                                      dbname: $obj_env_yml['postgres']['database'],
                                      port: '5432',
                                      password: $obj_env_yml['postgres']['password'])
      puts 'Successfully created connection to database'

      connection.exec("DELETE FROM form WHERE id LIKE '%#{env.upcase}%';")
      puts 'SIT vessel deleted'
      connection.exec("DELETE FROM comment WHERE form_id LIKE '%#{env.upcase}%';")
      puts 'SIT comment deleted'

      result_set = connection.exec("SELECT * FROM comment WHERE form_id LIKE '%#{env.upcase}%';")
      result_set.each do |row|
        puts "Comment data row = #{row}"
      end

      result_set = connection.exec("SELECT * FROM form WHERE id LIKE '%#{env.upcase}%';")
      result_set.each do |row|
        puts "Form data row = #{row}"
      end
    rescue PG::Error => e
      puts e.message
    ensure
      connection&.close
    end

  end
end
