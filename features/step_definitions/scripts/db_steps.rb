# frozen_string_literal: true

require_relative '../../../service/db_service'
require_relative '../../../library/utils/postgres'

Given('DB service clear couch table') do |table|
  db_service ||= DBService.new
  table.hashes.each do |row|
    response = db_service.retrieve_table(row['db_type'], row['table'])
    db_service.delete_table(row['db_type'], row['table'], response)
  end
end

Given('DB service clear postgres data') do
  postgres = Postgres.new
  postgres.clear_savefue_db
  postgres.clear_reporting_db
end
